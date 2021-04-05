import 'dart:io';
import 'dart:ui' as ui show Image;
import 'dart:ui' as ui show ImageByteFormat;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:usefullpayment/core/api/firebase_qr_detector.dart';
import 'package:usefullpayment/core/api/firebase_storage.dart';

class QRImageWidget extends StatefulWidget {
  final String product;

  QRImageWidget({Key? key, required this.product}) : super(key: key);

  @override
  _QRImageWidgetState createState() => _QRImageWidgetState();
}

class _QRImageWidgetState extends State<QRImageWidget> {
  GlobalKey _repaintQrImage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60,
      ),
      child: _qrImage(),
    );
  }

  void _productCallback(product) {}

  _qrImage() {
    return RepaintBoundary(
      key: _repaintQrImage,
      child: GestureDetector(
        onTap: () {
          _captureByteData().then((imageFile) {
            FirebaseQrDetector(imageFile, _productCallback).detectQrCode();
          });
        },
        child: QrImage(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(40.0),
          data: widget.product,
          size: 300,
        ),
      ),
    );
  }

  Future<File> _captureByteData() async {
    RenderRepaintBoundary boundary = _repaintQrImage.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 3.0,
    );
    var byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    File imageFile = File(await FirebaseStorage.getFilePath());
    return await FirebaseStorage.writeQrImage(imageFile, byteData!);
  }
}
