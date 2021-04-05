import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usefullpayment/bloc/qr_bloc.dart';
import 'package:usefullpayment/bloc/qr_event.dart';

class ProductFormWidget extends StatelessWidget {
  final String category;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  ProductFormWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    final QrBloc qrBloc = BlocProvider.of<QrBloc>(context);
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Flexible(child: _productTextField()),
          ElevatedButton(
            onPressed: () {
              qrBloc.dispatch(FormQrEvent(
                productItem: _textController.text,
              ));
            },
            child: Text('Product $category'),
          ),
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
}
