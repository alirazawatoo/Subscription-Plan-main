import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_models.freezed.dart';
part 'application_models.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  factory ApiResponse({
    @Default(500) int? statusCode,
    required dynamic data,
  }) = _ApiResponse;
  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}
// To parse this JSON data, do
//
//     final subscriptions = subscriptionsFromJson(jsonString);

Subscriptions subscriptionsFromJson(String str) =>
    Subscriptions.fromJson(json.decode(str));

String subscriptionsToJson(Subscriptions data) => json.encode(data.toJson());

class Subscriptions {
  String plan;
  String date;
  int daysLeft;
  List<Subscription> subscriptions;

  Subscriptions({
    required this.plan,
    required this.date,
    required this.daysLeft,
    required this.subscriptions,
  });

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        plan: json["plan"],
        date: json["date"],
        daysLeft: json["daysLeft"],
        subscriptions: List<Subscription>.from(
            json["subscriptions"].map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
        "date": date,
        "daysLeft": daysLeft,
        "subscriptions":
            List<dynamic>.from(subscriptions.map((x) => x.toJson())),
      };
}

class Subscription {
  int id;
  String name;
  int price;
  String currency;
  List<String> features;
  int duration;

  Subscription({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.features,
    required this.duration,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        currency: json["currency"],
        features: List<String>.from(json["features"].map((x) => x)),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "currency": currency,
        "features": List<dynamic>.from(features.map((x) => x)),
        "duration": duration,
      };
}
