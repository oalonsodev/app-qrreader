// Importaciones naturales
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// Importaciones personalizadas
import 'package:qrreader/src/models/scan_model.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController map = new MapController();

	@override
	Widget build(BuildContext context) {
		// Variables del método build (método principal)
		//* Este método permite compartir información entre rutas
		final ScanModel scan = ModalRoute.of(context).settings.arguments;

		return Scaffold(
			appBar: AppBar(
				title: Text('Visualizador de mapas'),
				centerTitle: true,
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.my_location),
						onPressed: () => map.move(scan.getLatLng(), 30),
					)
				],
			),
			body: _createFlutterMap(scan),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.repeat),
        onPressed: (){}
      ),
		);
	}

	Widget _createFlutterMap(ScanModel scan) {
		return FlutterMap(
			options: MapOptions(
        controller: map,
				center: scan.getLatLng(),
				zoom: 15.0,
			),
			layers: [
        _createMap(),
        _createMarker(scan),
      ]
		);
	}

	LayerOptions _createMap() => TileLayerOptions(
    urlTemplate: 'https://api.mapbox.com/styles/v1/'
      '{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
    additionalOptions: {
      'accessToken'	:	'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
      'id'					:	'mapbox/streets-v11'
                    /* outdoors-v11, light-v10, dark-v10, satellite-v9, satellite-streets-v11 */
    }
  );

  LayerOptions _createMarker(ScanModel scan) => MarkerLayerOptions(
    markers: <Marker>[
      Marker(
        point: scan.getLatLng(),
        builder: (context) => Center(
          child: Icon(
            Icons.location_on,
            size: 45.0,
          )
        )
      )
    ]
  );
}
