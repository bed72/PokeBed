import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:bed/src/domain/entities/pokemons/pokemons_entity.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

part 'pokemons_state.dart';
part 'pokemons_event.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  late final PokemonsUseCase _pokemonsUseCase;

  PokemonsBloc(this._pokemonsUseCase) : super(PokemonsInitial()) {
    on<GetPokemonsEvent>(loadPokemons);
  }

  Future<void> loadPokemons(
    GetPokemonsEvent event,
    Emitter<PokemonsState> emit,
  ) async {
    emit(PokemonsLoading());

    final data = await _pokemonsUseCase(PokemonsParams(url: event.params));

    data.fold(
      (left) => emit(PokemonsFailure(left.message)),
      (right) => emit(PokemonsSuccess(right)),
    );
  }
}
