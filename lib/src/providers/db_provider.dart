// Importaciones naturales
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
//Importaciones personalizadas
import 'package:qrreader/src/models/scan_model.dart';
// Permite visualizar el archivo scan_model en todos los lugares
// donde se importe el archivo db_provider.
export 'package:qrreader/src/models/scan_model.dart';

class DBProvider {

	static Database _database;
	static final DBProvider db = DBProvider._();

	DBProvider._();

	Future<Database> get database async {
		if (_database != null) return _database;

		_database = await initDB();

		return _database;
	}

  // Método para inicializar la base de datos
	Future<Database> initDB() async{
		// Obtener la ubicación física de nuestra aplicación
		Directory documentsDirectory = await getApplicationDocumentsDirectory();

		// Obtener la ubicacion física de nuestra base de datos
		final path = join( documentsDirectory.path, 'ScansDB.db' );

		return await openDatabase(
			path,
			version: 1,
			onOpen: (db) {},
			onCreate: (Database db, int version) async{
				await db.execute(
					'CREATE TABLE Scans ('
					'	id INTEGER PRIMARY KEY,'
					'	tipo TEXT,'
					'	valor TEXT'
					')'
				);
			},
		);

	}

	// Crear registros - INSERT (método sin procesar)
	Future<int> _insertScansRaw( ScanModel scan ) async {
	// Método privado, pues no se utilizará para crear registros
		// Obtener la base de datos
		final db = await database;
		// Crear un registro en la base de datos
		final resp = await db.rawInsert(
			"INSERT Into Scans ( id, tipo, valor ) "
			"VALUES ( ${scan.id}, '${scan.tipo}', '${scan.valor}' )"
		);
		// Retornar resultado de la operación
		return resp;
	}
	// Crear registros - INSERT (método mediante helpers)
	Future<int> insertScans( ScanModel scan ) async {
		// Obtener la base de datos
		final db = await database;
		// Crear un registro en la base de datos
		final resp =  db.insert(
			'Scans',
			scan.toJson()
		);
		// Retornar resultado de la operación
		return resp;
	}

	// Obtener registros - SELECT (método mediante helpers)
	Future<ScanModel> selectIdScans( int id ) async { // Obtener por Id
		// Obtener la base de datos
		final db =await database;
		// Obtener un registro de la base da datos mediante el Id
		final resp = await db.query(
			'Scans',
			where: 'id = ?',
			whereArgs: [ id ]
		);
		// Retornar el Scan encontrado
		return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : null;
	}
	// Obtener registros - SELECT (método mediante helpers)
	Future<List<ScanModel>> selectAllScans() async { // Obtener todos los registros
		// Obtener la base de datos
		final db =await database;
		// Obtener todos los registros de la base de datos
		final resp = await db.query(
			'Scans',
		);
		// Retornar la lista de Scans
		return resp.isNotEmpty 
			? resp.map( (item) => ScanModel.fromJson(item) ).toList()
			: null;
	}
	// Obtener registros - SELECT (método mediante helpers)
	Future<List<ScanModel>> selectTypeScans(String tipo) async { // Obtener por tipo
		// Obtener la base de datos
		final db = await database;
		// Obtener los registros de un determinado tipo
		final resp = await db.query(
			'Scans',
			where: 'tipo = ?',
			whereArgs: [ tipo ]
		);
		// Retornar la lista de Scans
		return resp.isNotEmpty
			? resp.map( (item) => ScanModel.fromJson(item) ).toList()
			: null;
	}

	// Actualizar registros - UPDATE (método mediante helpers)
	Future<int> updateScan( ScanModel scan ) async {
		// Obtener la base de datos
		final db = await database;
		// Actualizar un registro de la base de datos mediante el Id
		final resp = await db.update(
			'Scans',
			scan.toJson(),
			where: 'id = ?',
			whereArgs: [ scan.id ]
		);
		// Retornar resultado de la operación
		return resp;
	}

	// Eliminar registros - DELETE (método mediante helpers)
	Future<int> deleteScan( int id ) async {
		// Obtener la base de datos
		final db = await database;
		// Eliminar un registro de la base de datos mediante el Id
		final resp = await db.delete(
			'Scans',
			where: 'id = ?',
			whereArgs: [ id ]
		);
		// Retornar la cantidad de registros eliminados
		return resp;
	}
	// Eliminar registros - DELETE (método sin procesar)
	Future<int> deleteAll() async {
		// Obtener la base de datos
		final db = await database; 
		// Eliminar todos los registros de la base de datos
		final resp = await db.rawDelete(
			"DELETE FROM Scans"
		);
		// Retornar la cantidad de registros eliminados
		return resp;
	}

}