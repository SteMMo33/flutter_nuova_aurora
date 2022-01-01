import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuova_aurora/ui/sub_menu_page.dart';
import 'package:provider/provider.dart';

import 'data/selectedItem.dart';


///
/// Punto d'ingresso dell'applicazione
/// Il codice segue il capitolo 19 del libro 'Flutter Apprentice'
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inizializzazione Firebase -> ovbbliga la modifica della firma del main()
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Inserimento del Multiprovider
    return MultiProvider(
      providers: [
        // TODO add changeNotifierProvider<Dao>

        /* Provider<OrdineDao>(
          lazy: false,
          create: (_) => OrdineDao(),
        ),*/
      ],

    child:
    /*SM return*/ MaterialApp(
      title: 'Pizz. Nuova Aurora',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Nuova Aurora'),
    ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  // By default, this allows you to interact with Firestore using the default Firebase App used whilst installing FlutterFire on your platform.
  // Non può essere richiamato prima della conclusione di initializeApp() !!

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logo300.jpg", scale: 0.2,),
            Expanded(child: buildMenuList()),
            Text("Pizzeria Nuova Aurora - Felino")
          ],
        ),
      ),

    );
  }


  /// Widget che gestisce la visualizzazione dei dati ritornati della query DB
  ///
  /// When performing a query, Firestore returns either a QuerySnapshot or a DocumentSnapshot.
  Widget buildMenuList() {

    CollectionReference menu = FirebaseFirestore.instance.collection('menu');
    return FutureBuilder<QuerySnapshot>(
      future: menu.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        // if (snapshot.hasData && !snapshot.data!.exists) {
        if (!snapshot.hasData) {
          // && !snapshot.data!.) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {

          // data : QuerySnapshot<Object>
          // docs : List<QuerySnapshot<Object>>
          // -> JsonQueryDocumentSnapshot
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          List<SelectedItem> items = <SelectedItem>[];

          // Loop su tutti i docs per creare la lista di SelectedItem
          docs.forEach((element) {
            print("> id:'${element.id}' - nome: '${element['nome']}'");
            SelectedItem item = new SelectedItem(id: element.id, nome: element['nome']);
            items.add(item);
          });

          return ListView.builder(
            itemCount: docs.length,
              itemBuilder: (context, n) => GestureDetector(
                onTap: () => {
                  print("Tap on '${docs[n]['nome']}'"),
                  //Navigator.pushNamed(context, docs[n]['nome'])
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubMenuPage( selection: items[n])
                    )
                  )
                },
                child:  Text(
                  docs[n]['nome'].toString(),
                  style: TextStyle(fontSize: 20, height: 2.1),
                  textAlign: TextAlign.center,
                )
              )
          );
        }

        return Text("loading ..");
      },
    );
  }


}
