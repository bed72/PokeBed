import 'package:flutter/material.dart';

import 'package:bed/src/presentation/routes/routes.dart';
import 'package:bed/src/presentation/widgets/provider_widget.dart';
import 'package:bed/src/presentation/extensions/context_extension.dart';
import 'package:bed/src/presentation/utils/localization/localization_config.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: 'home',
        restorationScopeId: 'app',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        supportedLocales: supportedLocales,
        navigatorKey: Navigation.navigatorKey,
        onGenerateRoute: Navigation.onGenerateRoute,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: (BuildContext context) => context.localize.appTitle,
      ),
    );
  }
}
