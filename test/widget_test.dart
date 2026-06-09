import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';

void main() {
  test('parses the subscription payload served by the mock API', () {
    const payload = '''
{"plan":"Premium","date":"22nd May,2023","daysLeft":54,
 "subscriptions":[{"id":1,"name":"Basic","price":112,"currency":"\$",
 "features":["a","b"],"duration":6}]}''';

    final subscriptions = subscriptionsFromJson(payload);

    expect(subscriptions.plan, 'Premium');
    expect(subscriptions.daysLeft, 54);
    expect(subscriptions.subscriptions.single.features, ['a', 'b']);
    expect(subscriptionsToJson(subscriptions), contains('"name":"Basic"'));
  });
}
