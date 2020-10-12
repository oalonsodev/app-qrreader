import 'dart:async';

import 'package:qrreader/src/models/scan_model.dart';

class Validators {

	//* 1er streamTransformer: validador de GEO
	//? En los StTrans se puede indicar el tipo de entrada y salida,como se ve
	//?																						AQUI			Y				AQUI
	final validarGeo = new StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
		handleData: (scans, sink) {
			//* Aquí se realizan las operaciones necesarias para filtrar los result.
			//? En este caso, creamos una lista que se llene solo de resultados GEO
			List geoScans = scans.where((scan) => scan.tipo == 'geo').toList();
			//? Despues, agregamos esa lista a la corriente del StreamB
			sink.add(geoScans);


		},
	);
	//* 2do streamTransformer: validador de Http
	//? En los StTrans se puede indicar el tipo de entrada y salida,como se ve
	//?																						AQUI			Y				AQUI
	final validarHttp = new StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
		handleData: (scans, sink) {
			//* Aquí se realizan las operaciones necesarias para filtrar los result.
			//? En este caso, creamos una lista que se llene solo de resultados GEO
			List geoScans = scans.where((scan) => scan.tipo == 'http').toList();
			//? Despues, agregamos esa lista a la corriente del StreamB
			sink.add(geoScans);


		},
	);

}