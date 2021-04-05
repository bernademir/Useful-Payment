abstract class QrEvent {}

class FormQrEvent extends QrEvent {
  final String productItem;

  FormQrEvent({required this.productItem});
}
