import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuova_aurora/data/selectedItem.dart';
import 'package:nuova_aurora/ui/sub_sub_menu_page.dart';


class SubMenuPage extends StatefulWidget {
  SubMenuPage({Key? key, required this.selection}) : super(key: key);

  final SelectedItem selection;

  @override
  _SubMenuPageState createState() => _SubMenuPageState();
}


class _SubMenuPageState extends State<SubMenuPage> {

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
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: buildMenuList(widget.selection)),
            Text(
              "Pizzeria Nuova Aurora - Felino",
              style: TextStyle( color: Colors.red),
            )

          ],
        ),
      ),

    );
  }


  ///
  /// Sembra non essere possibile elencare le collection sotto un documento, quindi defnisco
  /// i nomi delle collezioni in modo statico
  ///
  Widget buildMenuList(SelectedItem selection) {

    print("> sub doc:'${selection.id}' - collection: '${selection.nome}'");

    List<String> collections = <String>[];

    if (selection.id=='bevande'){
      collections.add("Bevande");
      collections.add("Dopo cena");
      collections.add("Lista dei vini");
    }
    else if (selection.id=='calzoni') {
       collections.add("calzoni");
       collections.add("pizze alte");
    }
    else if (selection.id=='pizze') {
       collections.add("pizze");
    }
    else if (selection.id=='dolci') {
       collections.add("dolci");
    }
    else if (selection.id=='speciali') {
       collections.add("speciali");
    }
    else if (selection.id=='ristorante') {
       collections.add("Antipasti");
       collections.add("Contorni");
       collections.add("Primi piatti");
       collections.add("Secondi");
    }
    else {
      return Text("${selection.id} - Non gestito");
    }

    return GridView.builder(
            itemCount: collections.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, n) => GestureDetector(
                onTap: () => {
                  print("Tap on '${collections[n]}'"),
                  //Navigator.pushNamed(context, docs[n]['nome'])
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubSubMenuPage( selection: SelectedItem( id: selection.id, nome: collections[n]),)
                    )
                  )
                },
                child: Card (
                    child: Expanded(
                        child: Column (
                        children: <Widget>[
                          Text(
                          collections[n],
                          style: TextStyle(fontSize: 20, height: 2.1),
                          textAlign: TextAlign.center,
                      ),
                      ]
                    )
                )
                )
              )
          );

  }


}
