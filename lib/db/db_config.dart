import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  Directory documentsDir = await getApplicationDocumentsDirectory();
  final path = join(documentsDir.path, 'db_v1.db');

  return await openDatabase(path, version: 1, onCreate: _createDB);
}

Future _createDB(Database db, int version) async {
  const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  const textType = 'TEXT NOT NULL';
  const dateTimeType = 'NUMERIC NOT NULL';

  await db.execute('''
    CREATE TABLE items (
      id $idType, 
      name $textType,
      price $textType,
      type $textType,
      quantity $textType,
      dateOfPurchase $dateTimeType,
      inventoryDate $dateTimeType
    )
  ''');

  await db.execute('''
    CREATE TABLE appointments (
      id $idType, 
      purpose $textType,
      date $dateTimeType,
      time $dateTimeType,
      totalExpenses $textType
    )
  ''');
}
