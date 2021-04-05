import 'package:flutter/material.dart';

class ProductFormWidget extends StatelessWidget {
  final Function(String) productCallback;
  final String category;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  ProductFormWidget({required this.category, required this.productCallback});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Flexible(child: _productTextField()),
          _productButton()
        ],
      ),
    );
  }

  _productTextField() {
    return TextFormField(
      controller: _textController,
      validator: (value) {
        return "Enter the product $category";
      },
    );
  }

  _productButton() {
    return ElevatedButton(
      onPressed: () {
        productCallback(_textController.text);
      },
      child: Text('Product $category'),
    );
  }
}
