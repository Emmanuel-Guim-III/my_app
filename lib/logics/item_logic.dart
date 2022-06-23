import 'package:my_app/models/item_model.dart';
import 'package:my_app/services/item_service.dart';

abstract class ItemLogic {
  Future<int> createItem(ItemModel item);
  Future<List<ItemModel>> getItems();
  Future<int> updateItem(ItemModel item);
  Future<int> deleteItem(int id);
}

class ItemLogicImpl implements ItemLogic {
  final ItemService _itemService;

  ItemLogicImpl(
    this._itemService,
  );

  @override
  Future<int> createItem(ItemModel item) async {
    return await _itemService.createItem(item);
  }

  @override
  Future<List<ItemModel>> getItems() async {
    return await _itemService.getItems();
  }

  @override
  Future<int> updateItem(ItemModel item) async {
    return await _itemService.updateItem(item);
  }

  @override
  Future<int> deleteItem(int id) async {
    return await _itemService.deleteItem(id);
  }
}
