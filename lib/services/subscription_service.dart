import 'package:flutter/services.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/api_service.dart';

import '../app/app.locator.dart';
import '../constants/constants.dart';

/// Loads the plan catalogue: from [remoteUrl] when one is configured,
/// otherwise from the bundled `db.json` so the app runs offline with demo data.
class SubscriptionService {
  SubscriptionService({
    this.apiService,
    AssetBundle? bundle,
    this.remoteUrl = plansUrl,
  }) : _bundle = bundle ?? rootBundle;

  /// Falls back to the locator's [ApiService] when not injected.
  final ApiService? apiService;
  final String remoteUrl;
  final AssetBundle _bundle;

  bool get usesRemoteSource => remoteUrl.isNotEmpty;

  Future<Subscriptions> getSubscriptions() async {
    if (!usesRemoteSource) {
      return subscriptionsFromJson(await _bundle.loadString(demoPlansAsset));
    }
    final api = apiService ?? locator<ApiService>();
    final response = await api.get(url: remoteUrl);
    return Subscriptions.fromJson(response.data);
  }
}
