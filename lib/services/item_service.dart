import 'dart:async';

import 'package:my_app/db/db_config.dart';
import 'package:my_app/models/item_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ItemService {
  Future<int> createItem(ItemModel item);
  Future<List<ItemModel>> getItems();
  Future<int> updateItem(ItemModel item);
  Future<int> deleteItem(int id);
}

class ItemServiceImpl implements ItemService {
  ItemServiceImpl();

  ItemServiceImpl._privateConstructor();
  static final ItemServiceImpl instance = ItemServiceImpl._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  @override
  Future<int> createItem(ItemModel item) async {
    final db = await instance.database;

    return await db.insert(
      'items',
      item.toMap(),
    );
  }

  @override
  Future<List<ItemModel>> getItems() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> items =
        await db.query('items', orderBy: 'name');

    List<ItemModel> itemList =
        items.isNotEmpty ? items.map((a) => ItemModel.fromMap(a)).toList() : [];

    return itemList;
  }

  @override
  Future<int> updateItem(ItemModel item) async {
    final db = await instance.database;

    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> deleteItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
