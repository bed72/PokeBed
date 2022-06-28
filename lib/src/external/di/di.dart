import 'package:bed/src/external/di/http/injection.dart';
import 'package:bed/src/external/di/storage/injection.dart';
import 'package:bed/src/external/di/pokemons/injection.dart';

final providers = [
  ...httpProvider,
  ...storageProvider,
  ...pokemonsProvider,
];
