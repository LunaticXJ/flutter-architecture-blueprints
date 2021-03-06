import 'package:app/constants.dart';
import 'package:app/ui/app_theme.dart';
import 'package:app/ui/component/loading.dart';
import 'package:app/ui/detail/datail_page.dart';
import 'package:app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = useProvider(appThemeNotifierProvider);
    final themeData = useMemoized(() => appTheme.themeData, [appTheme.setting]);
    final snapshot = useFuture(themeData);

    return snapshot.hasData
        ? MaterialApp(
            title: 'Flutter Architecture Blueprints',
            theme: snapshot.data ?? lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routes: {
              Constants.PAGE_HOME: (context) => HomePage(),
              Constants.PAGE_DETAIL: (context) => DetailPage(),
            },
          )
        : const Center(child: Loading());
  }
}
