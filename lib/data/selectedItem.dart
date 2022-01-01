
import 'package:cloud_firestore/cloud_firestore.dart';


class SelectedItem {

	final String nome;
	final String desc;
	final String id;
	final double prezzo;

	//DocumentReference? reference;

	// Costruttore
	SelectedItem( { required this.id, required this.nome, this.desc="", this.prezzo = 0.0 } );

	// Costruttori Factory per la conversione da/per JSON e snapshot
	//factory Menu.fromSnapshot(DocumentSnapshot snapshot) {
		// final message = Menu.fromJson(snapshot.data() as Map<String, dynamic>);
		//message.reference = snapshot.reference;
		//return message;
	//}

}