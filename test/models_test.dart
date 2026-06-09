import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_test/flutter_test.dart';

const _payload = '''
{"plan":"Standard","date":"22 May 2027","daysLeft":54,
 "subscriptions":[
  {"id":1,"name":"Basic","price":9,"currency":"\$","features":["a","b"],"duration":1},
  {"id":2,"name":"Premium","price":89.5,"currency":"\$","features":[],"duration":12}
 ]}''';

void main() {
  test('parses the plan catalogue and round-trips it to JSON', () {
    final subscriptions = subscriptionsFromJson(_payload);

    expect(subscriptions.plan, 'Standard');
    expect(subscriptions.daysLeft, 54);
    expect(subscriptions.subscriptions, hasLength(2));
    expect(subscriptions.subscriptions.first.features, ['a', 'b']);

    final again = subscriptionsFromJson(subscriptionsToJson(subscriptions));
    expect(again.toJson(), subscriptions.toJson());
  });

  test('formats whole and fractional prices and the billing period', () {
    final plans = subscriptionsFromJson(_payload).subscriptions;

    expect(plans[0].formattedPrice, '\$9');
    expect(plans[0].billingPeriod, 'month');
    expect(plans[1].formattedPrice, '\$89.50');
    expect(plans[1].billingPeriod, '12 months');
  });

  test('rejects payloads with missing or mistyped fields', () {
    expect(() => subscriptionsFromJson('{"plan":"Basic"}'),
        throwsFormatException);
    expect(() => subscriptionsFromJson('[]'), throwsFormatException);
    expect(
      () => subscriptionsFromJson(_payload.replaceFirst('"price":9', '"price":"9"')),
      throwsFormatException,
    );
    expect(
      () => subscriptionsFromJson(_payload.replaceFirst('["a","b"]', '["a",2]')),
      throwsFormatException,
    );
  });
}
