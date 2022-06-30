import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:bed/src/domain/entities/pokemons/pokemon_entity.dart';
import 'package:bed/src/domain/entities/pokemons/pokemons_entity.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

part 'pokemons_state.dart';

class PokemonsBloc extends Cubit<PokemonsState> {
  late final PokemonsUseCase _pokemonsUseCase;
  late final List<PokemonEntity> _pokemons = [];

  PokemonsBloc(this._pokemonsUseCase) : super(PokemonsInitial());

  Future<void> loadPokemons(PokemonsParams params) async {
    _pokemons.isEmpty ? emit(PokemonsLoading()) : emit(PokemonsPagingLoading());

    final data = await _pokemonsUseCase(params);

    data.fold(
      (left) => emit(PokemonsFailure(left.message)),
      (right) {
        _pokemons.addAll(right.results);

        emit(PokemonsSuccess(right.copyWith(results: _pokemons)));
      },
    );
  }
}
