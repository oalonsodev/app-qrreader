// Importaciones naturales
import 'package:flutter/material.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
// Importaciones personalizadas


openScan( BuildContext context, ScanModel scan ) async {

  if (scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'El sitio ${scan.valor} no pudo ser abierto :(';
    }

  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}