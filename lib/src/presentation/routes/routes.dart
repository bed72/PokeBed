import 'package:flutter/material.dart';

import 'package:bed/src/external/singletons/navigation_singleton.dart';

import 'package:bed/src/presentation/screens/pokemons/pokemons_screen.dart';

class Navigation {
  static GlobalKey<NavigatorState> get navigatorKey =>
      NavigationSingleton.instance.navigator;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // ignore: prefer_typing_uninitialized_variables
    late final Widget widget;
    // ignore: unused_local_variable
    late final args = settings.arguments;

    switch (settings.name) {
      case PokemonsScreen.pokemonsPath:
        widget = const PokemonsScreen();
        break;
      default:
        widget = const PokemonsScreen();
        break;
    }

    return MaterialPageRoute(builder: (BuildContext context) => widget);
  }
}
