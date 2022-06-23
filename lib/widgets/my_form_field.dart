import 'package:flutter/material.dart';

class MyFormField {
  static TextFormField textField({
    required String value,
    required String label,
    required ValueChanged onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onChanged: onChanged,
    );
  }

  static TextFormField numberField({
    required String value,
    required String label,
    required ValueChanged onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }

  static TextFormField priceField({
    required String value,
    required String label,
    required ValueChanged onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        suffixText: 'PHP',
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }
}
