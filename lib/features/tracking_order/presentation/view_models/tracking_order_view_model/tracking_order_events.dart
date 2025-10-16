

abstract class TrackingOrderEvent {}

class GetAllPaindingOrdersEvent extends TrackingOrderEvent {}

class GetDataFromRemoteEvent extends TrackingOrderEvent {
  String orderId;
  GetDataFromRemoteEvent(this.orderId);
}

class CallUserEvent extends TrackingOrderEvent {
  final String phoneNumber;
  CallUserEvent(this.phoneNumber);
}

class WhatsAppUserEvent extends TrackingOrderEvent {
  final String phoneNumber;
  final String? message;
  WhatsAppUserEvent(this.phoneNumber, {this.message});
}
