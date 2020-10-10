// Importaciones naturales
import 'package:flutter/material.dart';
// Impotaciones personalizadas
import 'package:qrreader/src/pages/home_page.dart';
import 'package:qrreader/src/pages/map_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
      
			title: 'QR Reader',

			theme: ThemeData(
				primaryColor: Colors.teal,
				
      ),
			
			initialRoute: 'home',
			routes: {
				'home'	: (BuildContext context) => HomePage(),
				'map'	  : (BuildContext context) => MapPage(),
			},
		);
	}
}