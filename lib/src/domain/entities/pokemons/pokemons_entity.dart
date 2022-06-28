import 'package:equatable/equatable.dart';

import 'package:bed/src/domain/entities/pokemons/pokemon_entity.dart';

class PokemonsEntity extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonEntity> results;

  const PokemonsEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  PokemonsEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonEntity>? results,
  }) =>
      PokemonsEntity(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}
