import 'dart:ui';

const Duration receiveTimeout = Duration(seconds: 15);
const Duration connectionTimeout = Duration(seconds: 15);

const Color kcPrimaryColor = Color(0xFF032726);
const Color kcSurfaceColor = Color(0xFF033C3A);
const Color kcSecondaryColor = Color(0xFF00B4AF);
const Color kcAccentColor = Color(0xFFEDA53D);
const Color kcTextColor = Color(0xFFEBEBF0);
const Color kcMutedTextColor = Color(0xFFB8C7C6);

/// Bundled demo data, used when no remote endpoint is configured.
const String demoPlansAsset = 'db.json';

/// Optional remote endpoint returning the same JSON shape as `db.json`.
/// Set at build time with `--dart-define=PLANS_URL=https://...`.
const String plansUrl = String.fromEnvironment('PLANS_URL');
