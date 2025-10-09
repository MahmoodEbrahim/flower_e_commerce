
abstract class TrackingEvent {}

class ListenToOrderStreamEvent extends TrackingEvent {
  final String orderId;

  ListenToOrderStreamEvent(this.orderId);
}
