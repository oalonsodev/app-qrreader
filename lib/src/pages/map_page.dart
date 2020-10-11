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
  final mapController = new MapController();

  String mapType = 'streets-v11';

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
						onPressed: (){
              mapController.move(scan.getLatLng(), 30);
            },
					)
				],
			),
			body: _createFlutterMap(scan),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _mapSelect()
      ),
		);
	}

	void _mapSelect(){
    switch (mapType) {
      case 'streets-v11':
        mapType = 'outdoors-v11';
        break;

      case 'outdoors-v11':
        mapType = 'light-v10';
        break;

      case 'light-v10':
        mapType = 'dark-v10';
        break;

      case 'dark-v10':
        mapType = 'satellite-v9';
        break;

      case 'satellite-v9':
        mapType = 'satellite-streets-v11';
        break;

      case 'satellite-streets-v11':
        mapType = 'streets-v11';
        break;

      default: mapType = 'streets-v11';
    }
    print('$mapType');
    setState((){});
  }

	Widget _createFlutterMap(ScanModel scan) {
		return FlutterMap(
			options: MapOptions(
        controller: mapController,
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
      'id'					:	'mapbox/$mapType'
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
