class OrderInfoEntity {
  final int totalPrice;
  final bool isDelivered;
  final String state;
  final String orderNumber;
  final String createdAt;
  final String updatedAt;
  final int v;

  OrderInfoEntity(
    this.isDelivered,
    this.state,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalPrice,
  );

  OrderInfoEntity copyWith({
    int? totalPrice,
    bool? isDelivered,
    String? state,
    String? orderNumber,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return OrderInfoEntity(
      isDelivered ?? this.isDelivered,
      state ?? this.state,
      orderNumber ?? this.orderNumber,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      v ?? this.v,
      totalPrice ?? this.totalPrice,
    );
  }
}
