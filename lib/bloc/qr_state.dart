class QrState {
  final String formButton;
  final String serializedProduct;

  QrState({required this.formButton, required this.serializedProduct});

  factory QrState.id() {
    return QrState(formButton: 'Id', serializedProduct: '');
  }

  factory QrState.name() {
    return QrState(formButton: 'Name', serializedProduct: '');
  }

  factory QrState.price() {
    return QrState(formButton: 'Price', serializedProduct: '');
  }

  factory QrState.qrCode(String serializedQrCode) {
    return QrState(
      formButton: 'Id',
      serializedProduct: serializedQrCode,
    );
  }
}
