import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuova_aurora/data/selectedItem.dart';

class SubSubMenuPage extends StatefulWidget {
  SubSubMenuPage({Key? key, required this.selection}) : super(key: key);

  final SelectedItem selection;

  @override
  _SubSubMenuPageState createState() => _SubSubMenuPageState();
}

class _SubSubMenuPageState extends State<SubSubMenuPage> {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.selection.nome),
        actions: [
          Padding (
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: null,
              child: Icon(Icons.search),
            )
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: buildMenuList(widget.selection)),
            Container(
              child: Text(
                "Pizzeria Nuova Aurora - Felino",
                style: TextStyle(
                    color: Colors.red,
                    backgroundColor: Colors.lightGreenAccent),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Widget che gestisce la visualizzazione dei dati ritornati della query DB
  ///
  /// When performing a query, Firestore returns either a QuerySnapshot or a DocumentSnapshot.
  ///
  Widget buildMenuList(SelectedItem selection) {
    print("> subsub  selection id: '${selection.id}' - nome: '${selection.nome}'");

    CollectionReference menu = FirebaseFirestore.instance
        .collection('menu')
        .doc(widget.selection.id)
        .collection(selection.nome);

    List<Map<String, dynamic>> listOfMaps = <Map<String, dynamic>>[];

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

          docs.forEach((element) {
            print(element['nome']);
            listOfMaps.add(element.data() as Map<String,dynamic>);
          });

          return ListView.builder(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 6.0, left: 3.0, right: 3.0),
            itemCount: docs.length,
            itemBuilder: (context, n) => GestureDetector(
                onTap: () => {
                      print("Tap on '${docs[n]['nome']}'"),
                      //Navigator.pushNamed(context, docs[n]['nome'])
                      /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context)=>FruitDetail(fruitDataModel: Fruitdata[index],)
                    )
                  );*/
                    },
                child: Card(
                    elevation: 3.0,
                    child: Row(children: [
                      Expanded(
                        child: Column(children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 3.0, left: 8.0),
                            child: Text(
                              docs[n]['nome'].toString(),
                              style: TextStyle(fontSize: 21, height: 2.1),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 8.0, bottom: 5.0),
                            child: Text(
                              listOfMaps[n].containsKey('ingredienti') ? listOfMaps[n]['ingredienti'] : "",
                              textAlign: TextAlign.left,
                              style: TextStyle(),
                            ),
                          )
                        ]),
                      ),
                      Text(
                        "€ ${docs[n]['prezzo'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ]))),
          );
        }

        return Text("loading ..");
      },
    );
  }
}
