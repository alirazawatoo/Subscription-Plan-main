import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/api_service.dart';
import 'package:flutter_stacked_starter/services/subscription_service.dart';
import 'package:stacked_services/stacked_services.dart';

/// Serves fixed strings as assets, so tests never touch the real bundle.
class StringAssetBundle extends CachingAssetBundle {
  StringAssetBundle(this.assets);

  final Map<String, String> assets;

  @override
  Future<ByteData> load(String key) async {
    final value = assets[key];
    if (value == null) throw FlutterError('Missing asset $key');
    return ByteData.sublistView(utf8.encoder.convert(value));
  }
}

/// Records GET calls and answers with [data], or throws [error] if set.
class FakeApiService implements ApiService {
  FakeApiService({this.data, this.error});

  final dynamic data;
  final Object? error;
  final List<String> requestedUrls = [];

  @override
  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  }) async {
    requestedUrls.add(url);
    if (error != null) throw error!;
    return ApiResponse(data: data, statusCode: 200);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A subscription service whose result is decided by the test.
class StubSubscriptionService extends SubscriptionService {
  StubSubscriptionService(this.respond);

  Future<Subscriptions> Function() respond;
  int calls = 0;

  @override
  Future<Subscriptions> getSubscriptions() {
    calls++;
    return respond();
  }
}

class RecordingDialogService extends DialogService {
  final List<DialogRequest> requests = [];

  @override
  Future<DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool hasImage = false,
    String? imageUrl,
    bool showIconInMainButton = false,
    String? mainButtonTitle,
    bool showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool takesInput = false,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = false,
    String barrierLabel = '',
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteTransitionsBuilder? transitionBuilder,
    dynamic customData,
    R? data,
  }) async {
    requests.add(DialogRequest(
      title: title,
      description: description,
      mainButtonTitle: mainButtonTitle,
      data: data,
      variant: variant,
    ));
    return null;
  }
}

DioException connectionFailure() => DioException(
      requestOptions: RequestOptions(path: '/plans'),
      type: DioExceptionType.connectionError,
    );

const demoCatalogue = '''
{"plan":"Standard","date":"22 May 2027","daysLeft":54,
 "subscriptions":[
  {"id":1,"name":"Basic","price":9,"currency":"\$","features":["Email support"],"duration":1},
  {"id":2,"name":"Standard","price":49,"currency":"\$","features":["Unlimited projects"],"duration":6},
  {"id":3,"name":"Premium","price":89.5,"currency":"\$","features":["Single sign-on"],"duration":12}
 ]}''';
