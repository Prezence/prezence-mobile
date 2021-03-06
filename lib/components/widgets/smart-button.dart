// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {

	const ButtonGroup({
		Key key,
		List<SmartButton> buttons
	}) : _buttons = buttons, super(key: key);
	
	final List<SmartButton> _buttons;

	@override
	Widget build(BuildContext context) {

		return Container(
			margin: EdgeInsets.all(0),
			child: Column(

				children: List.generate(_buttons.length, (index) {

					EdgeInsets _padding = (index + 1 != _buttons.length)
						? EdgeInsets.only(bottom: 12)
						: EdgeInsets.zero;

					return new Padding(padding: _padding, child: _buttons[index]);
				}) 
			)
		);
	}
}

class SmartButton extends StatelessWidget {

	const SmartButton({
		Key key,
		String text,
		@required Function onPressed,
	}) : _text = text, _onPressed = onPressed, super(key: key);

	final Function _onPressed;
	final String _text;

	@override
	Widget build(BuildContext context) {

		return Container(
			constraints: BoxConstraints.expand(height: 48),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.black)
			),
			child: RaisedButton(
				child: Text(
					_text,
						style: TextStyle(
							fontWeight: FontWeight.w200, fontSize: 20
						)
					),					
				textTheme: ButtonTextTheme.primary,
				textColor: Colors.orange[50],
				color: Colors.black54,
				highlightColor: Colors.yellow[700].withOpacity(0.36),
				splashColor: Colors.yellow[50].withOpacity(0.48),
				disabledColor: Colors.black26,
				elevation: 5,
				disabledElevation: 1,
				highlightElevation: 6,				
				onPressed: _onPressed
			)
		);
	}
}