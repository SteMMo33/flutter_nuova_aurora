
import 'package:cloud_firestore/cloud_firestore.dart';


class Menu {
	final String nome;
	final int id;

	DocumentReference? reference;

	// Costruttore
	Menu( { required this.id, required this.nome });

	// Costruttori Factory per la conversione da/per JSON e snapshot
/*
	factory Menu.fromJson( Map<dynamic, dynamic> json) => Menu(
		nome: json['text'] as String
	);

	Map<String, dynamic> toJson() => <String, dynamic>{
		'text': nome
	};
*/
	//factory Menu.fromSnapshot(DocumentSnapshot snapshot) {
		// final message = Menu.fromJson(snapshot.data() as Map<String, dynamic>);
		//message.reference = snapshot.reference;
		//return message;
	//}

}