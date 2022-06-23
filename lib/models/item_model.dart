import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemModel {
  final int? id;
  final String name;
  final String price;
  final String type;
  final String quantity;
  final DateTime dateOfPurchase;
  final DateTime inventoryDate;

  const ItemModel({
    this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.quantity,
    required this.dateOfPurchase,
    required this.inventoryDate,
  });

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        type: json['type'],
        quantity: json['quantity'],
        dateOfPurchase: DateTime.parse(json['dateOfPurchase']),
        inventoryDate: DateTime.parse(json['inventoryDate']),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'quantity': quantity,
      'dateOfPurchase': dateOfPurchase.toString(),
      'inventoryDate': inventoryDate.toString(),
    };
  }

  @override
  String toString() {
    return '''
      Appointment{
        id: $id, 
        name: $name, 
        price: $price, 
        type: $type, 
        quantity: $quantity, 
        dateOfPurchase: $dateOfPurchase, 
        inventoryDate: $inventoryDate
      }
    ''';
  }

  ItemResult formatProps(BuildContext context) {
    return ItemResult(
      id: id.toString(),
      name: name,
      price: double.parse(price).toStringAsFixed(2),
      type: type,
      quantity: quantity,
      dateOfPurchase: DateFormat('MMM dd, yyyy').format(dateOfPurchase),
      inventoryDate:
          DateFormat('MMM dd, yyyy  hh:mm aaa').format(inventoryDate),
    );
  }
}

class ItemResult {
  final String id;
  final String name;
  final String price;
  final String type;
  final String quantity;
  final String dateOfPurchase;
  final String inventoryDate;

  const ItemResult({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.quantity,
    required this.dateOfPurchase,
    required this.inventoryDate,
  });
}
