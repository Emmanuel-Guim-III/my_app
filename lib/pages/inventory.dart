import 'package:flutter/material.dart';
import 'package:my_app/logic_provider.dart';
import 'package:my_app/logics/item_logic.dart';
import 'package:my_app/models/item_model.dart';
import 'package:my_app/page_routes.dart' as routes;
import 'package:my_app/utils/date_time.dart' as date_time;

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  late ItemLogic _itemLogic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemLogic = LogicProvider.of(context)!.itemLogic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: FutureBuilder<List<ItemModel>>(
                  future: _itemLogic.getItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ItemModel>> items) {
                    if (!items.hasData) {
                      return const Center(child: Text('Loading...'));
                    }

                    return items.data!.isEmpty
                        ? const Center(
                            child: Text('No Item yet!'),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Type')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Date Of Purchase')),
                                DataColumn(label: Text('Inventory Date')),
                              ],
                              rows: _buildDataRows(items),
                              showCheckboxColumn: false,
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showItemAddingForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<DataRow> _buildDataRows(
    AsyncSnapshot<List<ItemModel>> items,
  ) {
    return items.data!.map(
      (item) {
        final itm = item.formatProps(context);

        return DataRow(
          cells: [
            DataCell(
              Text(itm.name),
              onLongPress: () {
                _showDeleteConfirmationDialog(item);
              },
            ),
            DataCell(Text(itm.price)),
            DataCell(Text(itm.type)),
            DataCell(Text(itm.quantity)),
            DataCell(Text(itm.dateOfPurchase)),
            DataCell(Text(itm.inventoryDate)),
          ],
          onSelectChanged: (bool? isSelected) {
            _showItemUpdatingForm(item);
          },
        );
      },
    ).toList();
  }

  void _showItemAddingForm() {
    final item = ItemModel(
      name: '',
      price: '',
      type: '',
      quantity: '',
      dateOfPurchase: date_time.getNowDateOnly(),
      inventoryDate: date_time.getDateTimeNow(),
    );

    Navigator.pushNamed(
      context,
      routes.itemAddingForm,
      arguments: item,
    );
  }

  void _deleteItem(int id) {
    _itemLogic.deleteItem(id);
    setState(() {});
  }

  void _showDeleteConfirmationDialog(ItemModel item) {
    final noBtn = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('No'),
    );

    final yesBtn = TextButton(
      onPressed: () {
        _deleteItem(item.id ?? 0);
      },
      child: const Text('Yes'),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete "${item.name}" item?'),
          content: const Text(
            'Doing so will permanently remove it from your record.',
          ),
          contentPadding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
          actions: [noBtn, yesBtn],
        );
      },
    );
  }

  void _showItemUpdatingForm(ItemModel item) {
    Navigator.pushNamed(
      context,
      routes.itemAddingForm,
      arguments: item,
    );
  }
}
