class CompletedOrder {
  final String serviceType;
  final String cost;
  final String paymentMethod;
  final String locationName;
  final String destinationName;
  final String orderId;

  CompletedOrder({
    required this.serviceType,
    required this.cost,
    required this.paymentMethod,
    required this.locationName,
    required this.destinationName,
    required this.orderId,
  });

  factory CompletedOrder.fromJson(Map<String, dynamic> json) {
    return CompletedOrder(
      serviceType: json['serviceType'],
      cost: json['cost'],
      paymentMethod: json['paymentMethod'],
      locationName: json['locationName'],
      destinationName: json['destinationName'],
      orderId: json['orderId'],
    );
  }
}
