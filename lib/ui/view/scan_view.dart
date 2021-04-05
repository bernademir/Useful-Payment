import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:usefullpayment/core/api/firebase_qr_detector.dart';
import 'package:usefullpayment/core/api/firebase_storage.dart';
import 'package:usefullpayment/core/model/product.dart';
import 'package:usefullpayment/ui/widget/scanned_product_widget.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  List<CameraDescription> cameras = [];
  late CameraController controller;
  bool isCameraInitialized = false;
  Product _product = Product(0, "", 0.0);

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized)
      return Container();
    else
      return Column(
        children: <Widget>[
          Expanded(flex: 2, child: _qrArea(context)),
          Expanded(flex: 1, child: _cameraButton()),
          Expanded(flex: 2, child: ScannedProductWidget(product: _product))
        ],
      );
  }

  _qrArea(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: _qrContainer(context),
        ),
      ),
    );
  }

  _qrContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      width: MediaQuery.of(context).size.width / 3 * 2,
      height: MediaQuery.of(context).size.width / 3 * 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }

  _cameraButton() {
    return IconButton(
      onPressed: () {
        saveQrCode().then((filePath) {
          _cropImage(File(filePath!)).then((croppedImage) {
            FirebaseQrDetector(croppedImage!, _productCallback).detectQrCode();
          });
        });
      },
      icon: Icon(
        Icons.camera_alt,
        size: 50,
      ),
    );
  }

  void _productCallback(product) {
    if (product != null)
      setState(() {
        _product = product;
      });
  }

  void _initializeController() {
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        isCameraInitialized = true;
      });
    });
  }

  _getCameras() async {
    cameras = await availableCameras();
    if (cameras.length > 0) _initializeController();
  }

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  Future<String?> saveQrCode() async {
    final String filePath = await FirebaseStorage.getFilePath();
    if (controller.value.isTakingPicture) return null;
    try {
      await controller.takePicture();
    } on CameraException catch (e) {
      throw Exception('Failed to capture image: $e');
    }
    return filePath;
  }

  Future<File?> _cropImage(File imageFile) async {
    return await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 250,
      maxHeight: 250,
    );
  }
}
