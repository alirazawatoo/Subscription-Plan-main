import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/app/app.logger.dart';
import 'package:flutter_stacked_starter/enums/basic_dialog_status.dart';
import 'package:flutter_stacked_starter/enums/dialog_type.dart';
import 'package:flutter_stacked_starter/exceptions/dio_exceptions.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/subscription_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    SubscriptionService? subscriptionService,
    DialogService? dialogService,
  })  : _subscriptionService =
            subscriptionService ?? locator<SubscriptionService>(),
        _dialogService = dialogService ?? locator<DialogService>();

  final log = getLogger('HomeViewModel');
  final SubscriptionService _subscriptionService;
  final DialogService _dialogService;

  Subscriptions? _subscriptions;
  Subscriptions? get subscriptions => _subscriptions;
  List<Subscription> get plans => _subscriptions?.subscriptions ?? const [];

  String? _loadError;

  /// User-facing reason the last load failed, or null after a good load.
  String? get loadError => _loadError;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Subscription? get selectedPlan =>
      _selectedIndex < plans.length ? plans[_selectedIndex] : null;

  bool get isCurrentPlanSelected =>
      selectedPlan != null && selectedPlan!.name == _subscriptions?.plan;

  Future<void> getSubscriptions({bool setViewToBusy = true}) async {
    _loadError = null;
    final request = _subscriptionService.getSubscriptions();
    try {
      _subscriptions = setViewToBusy
          ? await runBusyFuture(request, throwException: true)
          : await request;
      final current = plans.indexWhere((p) => p.name == _subscriptions!.plan);
      _selectedIndex = current == -1 ? 0 : current;
    } on DioException catch (e) {
      _loadError = DioExceptions.fromDioError(e).message;
      log.e('Loading plans failed: $_loadError');
    } on FormatException catch (e) {
      _loadError = 'The plan data could not be read';
      log.e('Malformed plan data: $e');
    }
    notifyListeners();
  }

  Future<void> onRefresh() => getSubscriptions(setViewToBusy: false);

  IconData getIcon(int index) {
    if (index == 0) {
      return Icons.send;
    } else if (index == 1) {
      return FontAwesomeIcons.crown.data;
    } else {
      return Icons.diamond;
    }
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> showConfirmationMessage() async {
    final plan = selectedPlan;
    if (plan == null) return;
    await _dialogService.showCustomDialog(
      variant: DialogType.basic,
      data: BasicDialogStatus.success,
      mainButtonTitle: 'OK',
      title: '${plan.name} Plan Subscribed',
      description: 'You just subscribed to ${plan.name} plan',
    );
  }
}
