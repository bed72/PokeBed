part of 'pokemons_bloc.dart';

@immutable
abstract class PokemonsState extends Equatable {
  const PokemonsState();

  @override
  List<Object> get props => [];
}

@immutable
class PokemonsInitial extends PokemonsState {}

@immutable
class PokemonsLoading extends PokemonsState {}

@immutable
class PokemonsFailure extends PokemonsState {
  final String message;

  const PokemonsFailure(this.message);

  @override
  List<Object> get props => [message];
}

@immutable
class PokemonsSuccess extends PokemonsState {
  final PokemonsEntity pokemons;

  const PokemonsSuccess(
    this.pokemons,
  );

  @override
  List<Object> get props => [pokemons];
}
