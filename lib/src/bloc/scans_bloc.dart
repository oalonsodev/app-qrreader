// Importaciones naturales.
import 'dart:async';
// Importaciones personalizadas.
import 'package:qrreader/src/bloc/validator.dart';
import 'package:qrreader/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obener los scans de la base de datos.
    getScans();
  }

  //* Controlador del Stream.
  final _streamcontroller = new StreamController<List<ScanModel>>.broadcast();

  //* Método para escuchar la información que fluye por el Stream. (General)
  //* Para documentación
  //* Stream<List<ScanModel>> get scansStream => _streamcontroller.stream;

  //? Método para escuchar la información que fluye por el Stream. (Solo Geo)
  Stream<List<ScanModel>> get scansStreamGeo =>
      _streamcontroller.stream.transform(validarGeo);
  //? Método para escuchar la información que fluye por el Stream. (Solo Http)
  Stream<List<ScanModel>> get scansStreamHttp =>
      _streamcontroller.stream.transform(validarHttp);

  // Método para cerrar las instancias que se pudiran crear.
  void _dispose() {
    _streamcontroller?.close();
  }

  //? Métodos para controlar el flujo de información.
  //* Obtener todos los scans del flujo.
  getScans() async {
    _streamcontroller.sink.add(await DBProvider.db.selectAllScans());
  }

  //* Agregar un scan al flujo.
  insertScan(ScanModel scan) async {
    // Insertar un scan al flujo.
    await DBProvider.db.insertScans(scan);
    // Actualizar l flujo, con el scan agregado.
    getScans();
  }

  //* Borrar un scan del flujo.
  deleteScan(int id) async {
    // Eliminar el scan.
    await DBProvider.db.deleteScan(id);
    // Actualizar el flujo, para reflejar el scan eliminado.
    getScans();
  }

  //* Eliminar todos los scans del flujo.
  deleteAll() async {
    // Eliminar los scans.
    await DBProvider.db.deleteAll();
    // Actualizar el flujo, para reflejar los scans eliminados.
    getScans();
  }
}
