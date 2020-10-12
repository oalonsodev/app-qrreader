// Importaciones naturales
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
// Impotaciones personalizadas
import 'package:qrreader/src/pages/maps_page.dart';
import 'package:qrreader/src/pages/directions_page.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	// Variables de la clase
	int menuindex = 0;

  final scanBloc = new ScansBloc();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Lector QR'),
				centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.white,),
            onPressed: scanBloc.deleteAll,
          )
        ],
			),

			body: _pages(),

			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: FloatingActionButton(
				backgroundColor: Colors.teal,
				child: Icon(Icons.camera),
				onPressed: () => _scanQR(context),
			),

			bottomNavigationBar: _buttonsBar(),
		);
	}

	Widget _pages() {
		if (menuindex == 1) return DirectionsPage();
		return MapsPage();
	}

	Widget _buttonsBar() {
		
		return BottomNavigationBar(
			currentIndex: menuindex,

			onTap: (select) => setState( () => menuindex = select ),

			items: [
				BottomNavigationBarItem(
					icon: Icon(Icons.map),
					label: 'Mapas',
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.group_work),
					label:'Direcciones',
				)

			],
		);
	}

	void _scanQR( BuildContext context ) async{
    String futureString = 'https://www.google.com';
    // String futureString = 'geo:40.774170787438734,-73.72853651484378';
    
    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    //   print('No hay dato leido');
    // }

    if(futureString != null){
      print(futureString);
      final scan = new ScanModel(valor: futureString);
      scanBloc.insertScan(scan);
    
      final scan2 = new ScanModel(valor: 'geo:40.774170787438734,-73.72853651484378');
      scanBloc.insertScan(scan2);
      
      // utils.openScan(context, scan);
    }


  }

}