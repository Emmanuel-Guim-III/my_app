import 'package:flutter/material.dart';
import 'package:my_app/logic_provider.dart';
import 'package:my_app/models/item_model.dart';
import 'package:my_app/page_routes.dart' as routes;
import 'package:my_app/utils/date_time.dart' as date_time;
import 'package:my_app/widgets/date_picker.dart';
import 'package:my_app/widgets/my_form_field.dart';

class ItemAddingForm extends StatefulWidget {
  final ItemModel? item;

  const ItemAddingForm({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  State<ItemAddingForm> createState() => ItemAddingFormState();
}

class ItemAddingFormState extends State<ItemAddingForm> {
  String nameMem = '';
  String get _name => nameMem;
  set _name(String v) => nameMem = v;

  String priceMem = '';
  String get _price => priceMem;
  set _price(String v) => priceMem = v;

  String quantityMem = '';
  String get _quantity => quantityMem;
  set _quantity(String v) => quantityMem = v;

  String typeMem = '';
  String get _type => typeMem;
  set _type(String v) => typeMem = v;

  DateTime dateOfPurchaseMem = date_time.getNowDateOnly();
  DateTime get _dateOfPurchase => dateOfPurchaseMem;
  set _dateOfPurchase(DateTime v) => dateOfPurchaseMem = v;

  @override
  void initState() {
    super.initState();

    _name = widget.item!.name;
    _price = widget.item!.price;
    _quantity = widget.item!.quantity;
    _type = widget.item!.type;
    _dateOfPurchase = widget.item!.dateOfPurchase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: MyFormField.textField(
                  label: 'Name',
                  value: _name,
                  onChanged: (v) {
                    setState(() {
                      _name = v;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: MyFormField.priceField(
                  label: 'Price',
                  value: _price,
                  onChanged: (v) {
                    setState(() {
                      _price = v;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: MyFormField.numberField(
                  label: 'Quantity',
                  value: _quantity,
                  onChanged: (v) {
                    setState(() {
                      _quantity = v;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: MyFormField.textField(
                  label: 'Type',
                  value: _type,
                  onChanged: (v) {
                    setState(() {
                      _type = v;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: DatePicker(
                  label: 'Date of Purchase',
                  value: _dateOfPurchase,
                  onChanged: (v) {
                    setState(() {
                      _dateOfPurchase = v;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () => _saveItem(widget.item!.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveItem(int? id) async {
    final item = ItemModel(
      id: id,
      name: _name,
      price: _price,
      type: _type,
      quantity: _quantity,
      dateOfPurchase: _dateOfPurchase,
      inventoryDate: date_time.getNowDateOnly(),
    );

    Navigator.popAndPushNamed(context, routes.inventory);

    final _itemLogic = LogicProvider.of(context)!.itemLogic;

    if (id == null) {
      await _itemLogic.createItem(item);
    } else {
      await _itemLogic.updateItem(item);
    }
  }
}
