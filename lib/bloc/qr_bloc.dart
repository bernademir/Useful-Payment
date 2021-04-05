import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usefullpayment/bloc/qr_event.dart';
import 'package:usefullpayment/bloc/qr_state.dart';
import 'package:usefullpayment/core/model/product.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  int _id = 0;
  String _name = "";
  double _price = 0.0;

  QrBloc(QrState initialState) : super(initialState);

  @override
  Stream<QrState> mapEventToState(QrEvent event) async* {
    var formInput = state.formButton;
    switch (formInput) {
      case 'Id':
        _id = int.parse((event as FormQrEvent).productItem);
        yield QrState.name();
        break;
      case 'Name':
        _name = (event as FormQrEvent).productItem;
        yield QrState.price();
        break;
      case 'Price':
        _price = double.parse((event as FormQrEvent).productItem);
        yield QrState.id();
        var product = Product(_id, _name, _price);
        var serializedProduct = json.encode(product);
        yield QrState.qrCode(serializedProduct);
        break;
    }
  }
}
