
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nuova_aurora/ui/menu_list.dart';

import 'ordine.dart';

/// Classe DAO Data Access Object per la collezione menu
class MenuDao {

	final CollectionReference collection = FirebaseFirestore.instance.collection('menu');

	/// Retrieval method
	Stream<QuerySnapshot> getOrdineStream(){
		return collection.snapshots();
	}


	Widget _buildListItem( BuildContext context, DocumentSnapshot snapshot) {
		final menu = MenuList.fromSnapshot(snapshot);
		//return MenuWidget(
		return Text("Menu"
		);
	}


	Widget _buildList ( BuildContext context, List<DocumentSnapshot>? snapshot){
		return ListView(
			 children: snapshot!.map((data) => _buildListItem( context, data)).toList(),
		);
	}

	Widget _getMenuList(MenuDao menuDao) {
		return Expanded(child:  StreamBuilder<QuerySnapshot>(
			stream: menuDao.getOrdineStream(),
			builder: (context, snapshot){
				if (!snapshot.hasData)
					return const Center( child: LinearProgressIndicator());

				return _buildList( context, snapshot.data!.docs);
			},
		)
		);
	}


}