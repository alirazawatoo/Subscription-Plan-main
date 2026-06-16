import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/api_service.dart';

import '../app/app.locator.dart';
import '../constants/constants.dart';

class SubscriptionService {
  final _apiService = locator<ApiService>();
  Future<Subscriptions> getSubscriptions() async {
    ApiResponse apiResponse = await _apiService.get(url: baseURL);
    return Subscriptions.fromJson(apiResponse.data);
  }
}
