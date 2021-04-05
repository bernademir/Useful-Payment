import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImageWidget extends StatelessWidget {
  final String product;

  const QRImageWidget({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60,
      ),
      child: _qrImage(),
    );
  }

  _qrImage() {
    return QrImage(
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(40.0),
      data: product,
      size: 300,
    );
  }
}
