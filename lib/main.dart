import 'dart:async';

import 'package:currency_converter/providers/package_info_provider.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:currency_converter/ui/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

_initLogger() {
  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) {};
  }
}

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final currencyServiceProvider = Provider<CurrencyService>((ref) {
  final dio = ref.read(dioProvider);
  return CurrencyService(dio);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initLogger();
      final packageInfo = await PackageInfo.fromPlatform();
      final sharedPreferences = await SharedPreferences.getInstance();
      runApp(
        ProviderScope(
          overrides: [
            packageInfoProvider.overrideWithValue(packageInfo),
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          ],
          child: const AppView(),
        ),
      );
    },
    (error, stackTrace) {},
  );
}
