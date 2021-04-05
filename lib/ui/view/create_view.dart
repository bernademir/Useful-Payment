import 'package:flutter/material.dart';
import 'package:usefullpayment/ui/widget/qr_form_widget.dart';
import 'package:usefullpayment/ui/widget/qr_image_widget.dart';

class CreateView extends StatefulWidget {
  @override
  _CreateViewState createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  String _product = "";
  void _productCallback(product) {
    setState(() {
      _product = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: QrFormWidget(
              serializedCallback: _productCallback,
            )),
        Expanded(flex: 4, child: QRImageWidget(product: _product)),
      ],
    );
  }
}
