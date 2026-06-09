import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/app/app.logger.dart';
import 'package:flutter_stacked_starter/enums/basic_dialog_status.dart';
import 'package:flutter_stacked_starter/enums/dialog_type.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/subscription_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final _dialogService = locator<DialogService>();
  final _subscriptionService = locator<SubscriptionService>();
  Subscriptions? _subscriptions;
  Subscriptions? get subscriptions => _subscriptions;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  Future<void> getSubscriptions({bool setViewToBusy = true}) async {
    try {
      final request = _subscriptionService.getSubscriptions();
      _subscriptions =
          setViewToBusy ? await runBusyFuture(request) : await request;
      notifyListeners();
    } on DioException catch (e) {
      log.e('DioException occurred: $e');
    } catch (e) {
      log.e('Generic exception: $e');
    }
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

  void showConfirmationMessage() {
    _dialogService.showCustomDialog(
      variant: DialogType.basic,
      data: BasicDialogStatus.success,
      mainButtonTitle: 'OK',
      title:
          '${_subscriptions?.subscriptions[_selectedIndex].name ?? ''} Plan Subscribed',
      description:
          'You just subscribed to ${_subscriptions?.subscriptions[_selectedIndex].name ?? ''} plan',
    );
  }
}
