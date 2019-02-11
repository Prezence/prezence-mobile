// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/subpage-header.dart';
import '../types/geometry.dart';

class HomeTabLibrary extends StatelessWidget {

	const HomeTabLibrary({
		Key key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		Geometry geometry = new Geometry(context);

		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[

				SubPageHeader(text: 'Library'),

				Expanded(					
					child: Padding(
						
						padding: const EdgeInsets.all(12.0),
						child: ListView(
						
							children: <Widget>[
								Card(
									margin: EdgeInsets.only(bottom: 24.0),
									color: Colors.black54,
									child: Container(
										constraints: BoxConstraints.expand(height: geometry.root ),
									),
								),
							],
					  	),
					),
				),

				Container(
					margin: EdgeInsets.only(bottom: 16),
					decoration: BoxDecoration(						
						color: Colors.black54,
						border: Border(
							top: BorderSide(color: Colors.black),
							bottom: BorderSide(color: Colors.black)
						)
					),
				  	child: Row(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							Padding(
							  	padding: const EdgeInsets.only(
									left: 8.0,
									right: 8.0									
								),
							  	child: Icon(Icons.search, size: 36.0, color: Colors.white54),
							),
							Expanded(
								child: TextField(
									style: TextStyle(color: Colors.white70, fontSize: 18.0),
								)
							,)
						]
					),
				),
			],
		);
	}
}