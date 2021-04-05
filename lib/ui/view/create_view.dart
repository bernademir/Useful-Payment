import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usefullpayment/bloc/qr_bloc.dart';
import 'package:usefullpayment/bloc/qr_state.dart';
import 'package:usefullpayment/ui/widget/product_form_widget.dart';
import 'package:usefullpayment/ui/widget/qr_image_widget.dart';

class CreateView extends StatefulWidget {
  @override
  _CreateViewState createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  late final QrBloc _qrBloc;

  QrState get initialState => QrState.id();

  Widget _createPage() {
    return BlocBuilder(
      bloc: _qrBloc,
      builder: (BuildContext context, QrState state) {
        return Column(
          children: <Widget>[
            ProductFormWidget(
              category: state.formButton,
            ),
            QRImageWidget(
              product: state.serializedProduct,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QrBloc>(
      create: (context) => QrBloc(initialState),
      child: _createPage(),
    );
  }
}
