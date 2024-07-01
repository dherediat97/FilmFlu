#!/bin/bash
flutter clean
find . -name "*.g.dart" -delete
find . -name "*.freezed.dart" -delete
flutter pub get
dart run build_runner build --delete-conflicting-outputs