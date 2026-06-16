# Subscription Plan UI

A Flutter/Stacked MVVM prototype for comparing Basic, Standard, and Premium plans across durations and currencies, then recording a simulated plan selection.

```text
load plan catalog -> choose duration/currency -> compare tiers -> select plan -> local confirmation
```

The application separates generated routing/service location, API access, subscription state, and view models. `db.json` supplies development data and `docs/demo.mov` shows the recorded UI flow.

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

This is a selection UI prototype. It does not demonstrate payment processing, store billing, receipt validation, recurring charges, or production expiration notifications. Currency/duration behavior depends on the development data contract. The app, emulator, code generation, and tests were not run during review.
