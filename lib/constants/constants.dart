import 'dart:ui';

const Duration receiveTimeout = Duration(seconds: 15);
const Duration connectionTimeout = Duration(seconds: 15);

const Color kcPrimaryColor = Color(0xFF032726);
const Color kcSecondaryColor = Color(0xFF00B4AF);

/// Bundled demo data, used when no remote endpoint is configured.
const String demoPlansAsset = 'db.json';

/// Optional remote endpoint returning the same JSON shape as `db.json`.
/// Set at build time with `--dart-define=PLANS_URL=https://...`.
const String plansUrl = String.fromEnvironment('PLANS_URL');
