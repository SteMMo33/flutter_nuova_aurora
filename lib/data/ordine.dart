
import 'package:cloud_firestore/cloud_firestore.dart';


class Ordine {
	final String nome;

	DocumentReference? reference;

	// Costruttore
	Ordine( {
		required this.nome
	});

	// Gestori conversione da/per JSON e snapshot

	factory Ordine.fromJson( Map<dynamic, dynamic> json) => Ordine(
		 nome: json['text'] as String
	);

	Map<String, dynamic> toJson() => <String, dynamic>{
		'text': nome
	};

	factory Ordine.fromSnapshot(DocumentSnapshot snapshot) {
		final message = Ordine.fromJson(snapshot.data() as Map<String, dynamic>);
		message.reference = snapshot.reference;
		return message;
	}
}