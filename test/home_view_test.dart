import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/app/app.locator.dart';
import 'package:flutter_stacked_starter/main.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/services/subscription_service.dart';
import 'package:flutter_stacked_starter/utils/shared/setup_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_services/stacked_services.dart';

import 'helpers.dart';

void main() {
  late StubSubscriptionService service;

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerSingleton<SubscriptionService>(service);
    setupDialogUi();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  }

  setUp(() {
    service = StubSubscriptionService(
        () async => subscriptionsFromJson(demoCatalogue));
  });

  tearDown(() => locator.reset());

  ElevatedButton actionButton(WidgetTester tester) =>
      tester.widget<ElevatedButton>(find.byType(ElevatedButton));

  testWidgets('shows the current plan and every plan on offer',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Standard Plan'), findsOneWidget);
    expect(find.text('54 days left'), findsOneWidget);
    expect(find.text('Your Standard plan will expire on 22 May 2027'),
        findsOneWidget);
    for (final name in ['Basic', 'Standard', 'Premium']) {
      expect(find.text(name), findsOneWidget);
    }
    expect(find.text('Current plan'), findsOneWidget);
    expect(find.text('\$89.50 / 12 months', findRichText: true),
        findsOneWidget);
    expect(find.text('CURRENT PLAN'), findsOneWidget);
    expect(actionButton(tester).onPressed, isNull);
  });

  testWidgets('selecting another plan and activating it confirms in a dialog',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();
    expect(find.text('ACTIVATE PREMIUM PLAN'), findsOneWidget);
    expect(actionButton(tester).onPressed, isNotNull);

    await tester.tap(find.text('ACTIVATE PREMIUM PLAN'));
    await tester.pumpAndSettle();
    expect(find.text('Premium Plan Subscribed'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Premium Plan Subscribed'), findsNothing);
  });

  testWidgets('a failed load shows the reason and retries on demand',
      (tester) async {
    service.respond = () async => throw connectionFailure();
    await pumpApp(tester);

    expect(find.text('Plans could not be loaded'), findsOneWidget);
    expect(find.text('Could not reach the API server'), findsOneWidget);

    service.respond = () async => subscriptionsFromJson(demoCatalogue);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.text('Standard Plan'), findsOneWidget);
    expect(service.calls, 2);
  });

  testWidgets('an empty catalogue explains that nothing is on offer',
      (tester) async {
    service.respond = () async => const Subscriptions(
          plan: 'Basic',
          date: '1 June 2027',
          daysLeft: 3,
          subscriptions: [],
        );
    await pumpApp(tester);

    expect(find.text('No plans on offer'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });
}
