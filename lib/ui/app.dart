import 'package:auto_route/auto_route.dart';
import 'package:currency_converter/providers/router_provider.dart';
import 'package:currency_converter/providers/scafold_messenger_key_provider.dart';
import 'package:currency_converter/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class AppView extends ConsumerWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    final scafoldMessengerKey = ref.read(scafoldMessengerKeyProvider);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          scaffoldMessengerKey: scafoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Cuurency Converter',
          theme: AppTheme.theme,
          routerDelegate: AutoRouterDelegate(
            router,
            navigatorObservers: () => [RouteObserver()],
          ),
          routeInformationParser: router.defaultRouteParser(),
        );
      },
    );
  }
}
