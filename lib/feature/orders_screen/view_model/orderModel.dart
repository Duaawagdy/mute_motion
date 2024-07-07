import 'dart:convert';
import 'dart:ffi';

class Order {
  final String serviceType;
  final String cost;
  final String paymentMethod;
  final String locationName;
  final String destinationName;
  final GeoPoint startLocation;
  final GeoPoint destination;
  final String orderid;
  final String passenger;

  Order({
    required this.serviceType,
    required this.cost,
    required this.paymentMethod,
    required this.locationName,
    required this.destinationName,
    required this.startLocation,
    required this.destination,
    required this.orderid,
    required this.passenger,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      serviceType: json['serviceType'] ?? '',
      cost: json['cost'] ?? '0.0', // Handle potential null or non-numeric values
      paymentMethod: json['paymentMethod'] ?? '',
      locationName: json['locationName'] ?? '',
      destinationName: json['destinationName'] ?? '',
      startLocation: GeoPoint.fromJson(json['startLocation']),
      destination: GeoPoint.fromJson(json['destination']),
      orderid: json['orderid'] ?? '',
      passenger: json['passenger'] ?? '',
    );
  }
}

class GeoPoint {
  final String type;
  final List<double> coordinates;

  GeoPoint({required this.type, required this.coordinates});

  factory GeoPoint.fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class PendingOrdersResponse {
  final List<Order> pendingOrders;

  PendingOrdersResponse({required this.pendingOrders});

  factory PendingOrdersResponse.fromJson(Map<String, dynamic> json) {
    return PendingOrdersResponse(
      pendingOrders: List<Order>.from(json['pendingOrders'].map((orderJson) => Order.fromJson(orderJson))),
    );
  }
}
