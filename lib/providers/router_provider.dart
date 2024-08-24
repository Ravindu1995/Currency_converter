import 'package:currency_converter/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
