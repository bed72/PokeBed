import 'package:get_it/get_it.dart';

import 'package:bed/src/data/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/domain/usecases/http/http_usecase.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/presentation/screens/pokemons/bloc/pokemons_bloc.dart';

class PokemonsInject {
  late final GetIt _getIt;

  PokemonsInject(this._getIt);

  void di() {
    _getIt.registerLazySingleton<PokemonsUseCase>(
      () => RemotePokemonsUseCase(
        _getIt<HttpUseCase>(),
      ),
    );

    _getIt.registerFactory<PokemonsBloc>(
      () => PokemonsBloc(
        _getIt<PokemonsUseCase>(),
      ),
    );
  }
}
