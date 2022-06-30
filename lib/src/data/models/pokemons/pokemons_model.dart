import 'package:bed/src/data/models/pokemons/pokemon_model.dart';
import 'package:bed/src/domain/entities/pokemons/pokemon_entity.dart';
import 'package:bed/src/domain/entities/pokemons/pokemons_entity.dart';

extension PokemonsModel on PokemonsEntity {
  static PokemonsEntity fromJson(Map<String, dynamic> json) => PokemonsEntity(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: _toJson(json['results']) // .cast<PokemonEntity>(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results,
      };

  static List<PokemonEntity> _toJson(List<dynamic> results) =>
      results.map((json) => PokemonModel.fromJson(json)).toList();
}
