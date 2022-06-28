import 'package:get_it/get_it.dart';
import 'package:bed/src/external/di/http/injection.dart';
import 'package:bed/src/external/di/storage/injection.dart';
import 'package:bed/src/external/di/pokemons/injection.dart';

class Inject {
  static initialized() {
    GetIt getIt = GetIt.instance;

    HttpInject(getIt).di();
    StorageInject(getIt).di();
    PokemonsInject(getIt).di();
  }
}
