
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuova_aurora/data/menu_dao.dart';


class MenuList {
	final String nome;

	DocumentReference? reference;

	// Costruttore base
	MenuList( { required this.nome });

	// Costruttori Factory per la conversione da/per JSON e snapshot

	factory MenuList.fromJson( Map<dynamic, dynamic> json) => MenuList(
		nome: json['text'] as String
	);

	Map<String, dynamic> toJson() => <String, dynamic>{
		'text': nome
	};

	factory MenuList.fromSnapshot(DocumentSnapshot snapshot) {
		final message = MenuList.fromJson(snapshot.data() as Map<String, dynamic>);
		message.reference = snapshot.reference;
		return message;
	}


	Widget _buildListItem( BuildContext context, DocumentSnapshot snapshot) {
		final menu = MenuList.fromSnapshot(snapshot);
		//return MenuWidget(
		return Text("Menu"
		);
	}

	Widget _buildList ( BuildContext context, List<DocumentSnapshot>? snapshot){
		return ListView(
			physics: const BouncingScrollPhysics(),
			 padding: const EdgeInsets.only( top: 20.0),
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
		));
	}


}