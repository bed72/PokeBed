import 'package:provider/provider.dart';

import 'package:bed/src/data/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/domain/usecases/http/http_usecase.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/presentation/screens/pokemons/bloc/pokemons_bloc.dart';

final pokemonsProvider = [
  Provider<PokemonsUseCase>(
    create: (context) => RemotePokemonsUseCase(
      context.read<HttpUseCase>(),
    ),
  ),
  Provider<PokemonsBloc>(
    create: (context) => PokemonsBloc(
      context.read<PokemonsUseCase>(),
    ),
  ),
];
