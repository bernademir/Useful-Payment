import 'package:flutter/material.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 3, child: _qrArea(context)),
        Expanded(flex: 1, child: _cameraButton())
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
      onPressed: () {},
      icon: Icon(
        Icons.camera_alt,
        size: 50,
      ),
    );
  }
}
