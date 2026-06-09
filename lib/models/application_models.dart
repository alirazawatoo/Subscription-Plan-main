import 'dart:convert';

class ApiResponse {
  const ApiResponse({required this.data, this.statusCode});

  final dynamic data;
  final int? statusCode;
}

Subscriptions subscriptionsFromJson(String str) =>
    Subscriptions.fromJson(json.decode(str));

String subscriptionsToJson(Subscriptions data) => json.encode(data.toJson());

class Subscriptions {
  const Subscriptions({
    required this.plan,
    required this.date,
    required this.daysLeft,
    required this.subscriptions,
  });

  /// Name of the plan the user is currently on.
  final String plan;

  /// Expiry date of the current plan, already formatted for display.
  final String date;
  final int daysLeft;
  final List<Subscription> subscriptions;

  /// Throws a [FormatException] when a field is missing or has the wrong type,
  /// so a malformed payload surfaces as an error state instead of a crash.
  factory Subscriptions.fromJson(Object? json) {
    if (json
        case {
          'plan': String plan,
          'date': String date,
          'daysLeft': int daysLeft,
          'subscriptions': List<dynamic> items,
        }) {
      return Subscriptions(
        plan: plan,
        date: date,
        daysLeft: daysLeft,
        subscriptions: [for (final item in items) Subscription.fromJson(item)],
      );
    }
    throw const FormatException('Unexpected subscriptions payload');
  }

  Map<String, dynamic> toJson() => {
        'plan': plan,
        'date': date,
        'daysLeft': daysLeft,
        'subscriptions': [for (final s in subscriptions) s.toJson()],
      };
}

class Subscription {
  const Subscription({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.features,
    required this.duration,
  });

  final int id;
  final String name;
  final num price;
  final String currency;
  final List<String> features;

  /// Billing period in months.
  final int duration;

  String get formattedPrice => price == price.roundToDouble()
      ? '$currency${price.toInt()}'
      : '$currency${price.toStringAsFixed(2)}';

  String get billingPeriod => duration == 1 ? 'month' : '$duration months';

  factory Subscription.fromJson(Object? json) {
    if (json
        case {
          'id': int id,
          'name': String name,
          'price': num price,
          'currency': String currency,
          'features': List<dynamic> features,
          'duration': int duration,
        } when features.every((feature) => feature is String)) {
      return Subscription(
        id: id,
        name: name,
        price: price,
        currency: currency,
        features: features.cast<String>().toList(growable: false),
        duration: duration,
      );
    }
    throw const FormatException('Unexpected subscription payload');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'currency': currency,
        'features': features,
        'duration': duration,
      };
}
