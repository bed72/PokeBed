import 'package:bed/src/domain/entities/pokemons/pokemon_entity.dart';

extension PokemonModel on PokemonEntity {
  static PokemonEntity fromJson(Map<String, dynamic> json) => PokemonEntity(
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
