import 'package:flutter/material.dart';
import 'package:usefullpayment/core/model/product.dart';

class ScannedProductWidget extends StatelessWidget {
  final Product product;

  const ScannedProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: SizedBox(
        width: 200,
        height: 250,
        child: Card(
          child: Column(
            children: <Widget>[
              Text('Qr Code Values'),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(product.productId.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text(product.productName.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text(product.productPrice.toString()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
