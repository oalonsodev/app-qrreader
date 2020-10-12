// Importaciones naturales
import 'package:flutter/material.dart';
// Importaciones personalizadas
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  //* Lista con todos los scans de la BD
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    //* Llamada que se ejecuta cada vez que se entra a la pantalla.
    //* Su finalidad es activar el controlador del Stream para que sea
    //* escuchado por el Stream y este redibuje la lista.
    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamGeo,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        
        if (snapshot.hasData) {
          final scans = snapshot.data;

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, iter){
              
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) => scansBloc.deleteScan(scans[iter].id),

                child: ListTile(
                  leading: Icon(Icons.map),
                  title: Text(scans[iter].valor),
                  subtitle: Text('${scans[iter].id}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => utils.openScan(context, scans[iter]),
                ),

              );
            },
          );
          
        } else {
          return Center(child: Text('¡Nada por aquí!'));
        }

      },
    );
  }
}