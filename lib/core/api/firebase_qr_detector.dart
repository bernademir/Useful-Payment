import 'dart:convert';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:usefullpayment/core/model/product.dart';

class FirebaseQrDetector {
  final File imageFile;
  final Function(Product) productCallback;

  FirebaseQrDetector(this.imageFile, this.productCallback);

  void detectQrCode() async {
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    BarcodeDetectorOptions options = BarcodeDetectorOptions(
      barcodeFormats: BarcodeFormat.qrCode,
    );
    final detector = FirebaseVision.instance.barcodeDetector(options);
    final List<Barcode> barcodes = await detector.detectInImage(visionImage);
    _extractProduct(barcodes);
  }

  _extractProduct(List<Barcode> barcodes) {
    for (Barcode barcode in barcodes) {
      final String rawValue = barcode.rawValue;
      final Map<String, dynamic> productMap = json.decode(rawValue);
      final Product product = Product.fromJson(productMap);
      productCallback(product);
    }
  }
}
