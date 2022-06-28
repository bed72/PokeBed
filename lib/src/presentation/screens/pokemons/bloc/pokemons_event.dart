part of 'pokemons_bloc.dart';

@immutable
abstract class PokemonsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

@immutable
class GetPokemonsEvent extends PokemonsEvent {
  late final String params;

  GetPokemonsEvent(this.params);

  @override
  List<Object?> get props => [params];
}
