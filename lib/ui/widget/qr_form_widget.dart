import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usefullpayment/core/model/product.dart';
import 'package:usefullpayment/ui/widget/product_form_widget.dart';

enum formState { id, name, price }

class QrFormWidget extends StatefulWidget {
  final Function(String) serializedCallback;

  const QrFormWidget({Key? key, required this.serializedCallback}) : super(key: key);
  @override
  _QrFormWidgetState createState() => _QrFormWidgetState();
}

class _QrFormWidgetState extends State<QrFormWidget> {
  var _state = formState.id;
  late int _id;
  late String _name;
  late double _price;

  void _formCallback(value) {
    formState state;
    switch (_state) {
      case formState.id:
        state = formState.name;
        _id = int.parse(value);
        break;
      case formState.name:
        state = formState.price;
        _name = value;
        break;
      case formState.price:
        state = formState.id;
        _price = double.parse(value);
        var product = Product(_id, _name, _price);
        var serializedProduct = json.encode(product);
        widget.serializedCallback(serializedProduct);
        break;
    }
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case formState.id:
        return ProductFormWidget(
          category: 'Id',
          productCallback: _formCallback,
        );
      case formState.name:
        return ProductFormWidget(
          category: 'Name',
          productCallback: _formCallback,
        );
      case formState.price:
        return ProductFormWidget(
          category: 'Price',
          productCallback: _formCallback,
        );
    }
  }
}
