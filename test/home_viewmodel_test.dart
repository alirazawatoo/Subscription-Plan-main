import 'package:flutter_stacked_starter/enums/basic_dialog_status.dart';
import 'package:flutter_stacked_starter/enums/dialog_type.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  late StubSubscriptionService service;
  late RecordingDialogService dialogs;

  HomeViewModel build() =>
      HomeViewModel(subscriptionService: service, dialogService: dialogs);

  setUp(() {
    service = StubSubscriptionService(
        () async => subscriptionsFromJson(demoCatalogue));
    dialogs = RecordingDialogService();
  });

  test('loads plans and preselects the plan the user is on', () async {
    final model = build();

    await model.getSubscriptions();

    expect(model.loadError, isNull);
    expect(model.plans, hasLength(3));
    expect(model.selectedPlan?.name, 'Standard');
    expect(model.isCurrentPlanSelected, isTrue);
    expect(model.isBusy, isFalse);
  });

  test('turns a network failure into a readable error', () async {
    service.respond = () async => throw connectionFailure();
    final model = build();

    await model.getSubscriptions();

    expect(model.subscriptions, isNull);
    expect(model.loadError, 'Could not reach the API server');
    expect(model.isBusy, isFalse);
  });

  test('reports malformed data instead of crashing', () async {
    service.respond = () async => throw const FormatException('bad');
    final model = build();

    await model.getSubscriptions();

    expect(model.loadError, 'The plan data could not be read');
  });

  test('a successful retry clears the previous error', () async {
    service.respond = () async => throw connectionFailure();
    final model = build();
    await model.getSubscriptions();

    service.respond = () async => subscriptionsFromJson(demoCatalogue);
    await model.onRefresh();

    expect(model.loadError, isNull);
    expect(model.plans, hasLength(3));
    expect(service.calls, 2);
  });

  test('confirms the selected plan through the custom dialog', () async {
    final model = build();
    await model.getSubscriptions();

    model.setSelectedIndex(2);
    expect(model.isCurrentPlanSelected, isFalse);
    await model.showConfirmationMessage();

    final request = dialogs.requests.single;
    expect(request.variant, DialogType.basic);
    expect(request.data, BasicDialogStatus.success);
    expect(request.title, 'Premium Plan Subscribed');
  });

  test('does nothing on confirm before plans have loaded', () async {
    await build().showConfirmationMessage();

    expect(dialogs.requests, isEmpty);
  });
}
