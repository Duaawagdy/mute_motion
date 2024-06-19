class PendingOrder {
  String? serviceType;
  String? cost;
  String? paymentMethod;
  String? locationName;
  String? destinationName;
  String? orderid;

  PendingOrder({
    this.serviceType,
    this.cost,
    this.paymentMethod,
    this.locationName,
    this.destinationName,
    this.orderid,
  });

  factory PendingOrder.fromJson(Map<String, dynamic> json) {
    return PendingOrder(
      serviceType: json['serviceType'] ?? '',
      cost: json['cost'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      locationName: json['locationName'] ?? '',
      destinationName: json['destinationName'] ?? '',
      orderid: json['orderid'] ?? '',
    );
  }
}

class PendingOrdersResponse {
  List<PendingOrder> pendingOrders;

  PendingOrdersResponse({required this.pendingOrders});

  factory PendingOrdersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['pendingOrders'] as List;
    List<PendingOrder> pendingOrdersList = list.map((i) => PendingOrder.fromJson(i)).toList();
    return PendingOrdersResponse(pendingOrders: pendingOrdersList);
  }
}
