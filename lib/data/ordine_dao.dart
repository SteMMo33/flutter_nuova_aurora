
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ordine.dart';


class OrdineDao {

	final CollectionReference collection = FirebaseFirestore.instance.collection('ordini');

	void saveOrdine(Ordine ordine){
		collection.add(ordine.toJson());
	}

	Stream<QuerySnapshot> getOrdineStream(){
		return collection.snapshots();
	}

}