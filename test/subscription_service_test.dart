import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/services/subscription_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  test('reads the bundled catalogue when no remote URL is configured', () async {
    final api = FakeApiService();
    final service = SubscriptionService(
      apiService: api,
      bundle: StringAssetBundle({demoPlansAsset: demoCatalogue}),
      remoteUrl: '',
    );

    final result = await service.getSubscriptions();

    expect(service.usesRemoteSource, isFalse);
    expect(result.plan, 'Standard');
    expect(result.subscriptions.map((s) => s.name),
        ['Basic', 'Standard', 'Premium']);
    expect(api.requestedUrls, isEmpty);
  });

  test('fetches from the remote URL when one is configured', () async {
    final api = FakeApiService(data: {
      'plan': 'Basic',
      'date': '1 June 2027',
      'daysLeft': 3,
      'subscriptions': <dynamic>[],
    });
    final service = SubscriptionService(
      apiService: api,
      bundle: StringAssetBundle({}),
      remoteUrl: 'https://plans.example.test/catalogue',
    );

    final result = await service.getSubscriptions();

    expect(api.requestedUrls, ['https://plans.example.test/catalogue']);
    expect(result.plan, 'Basic');
    expect(result.subscriptions, isEmpty);
  });

  test('surfaces a malformed remote payload as a FormatException', () {
    final service = SubscriptionService(
      apiService: FakeApiService(data: 'not json'),
      remoteUrl: 'https://plans.example.test/catalogue',
    );

    expect(service.getSubscriptions(), throwsFormatException);
  });

  test('the shipped db.json is valid demo data', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final result = await SubscriptionService(remoteUrl: '').getSubscriptions();

    expect(result.subscriptions, isNotEmpty);
    expect(
      result.subscriptions.map((s) => s.name),
      contains(result.plan),
      reason: 'the current plan must be one of the listed plans',
    );
  });
}
