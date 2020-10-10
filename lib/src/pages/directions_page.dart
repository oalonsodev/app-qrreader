// Importaciones naturales
import 'package:flutter/material.dart';
// Importaciones personalizadas
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class DirectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Variables de la clase
    final scansBloc = new ScansBloc();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){

        if (snapshot.hasData) {
          final scans = snapshot.data;

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) => scansBloc.deleteScan(scans[index].id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue),
                  title: Text(scans[index].valor),
                  subtitle: Text('ID: ${scans[index].id}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => utils.openScan(context, scans[index]),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No hay información para mostrar.'));
        }
      }
    );

  }
}