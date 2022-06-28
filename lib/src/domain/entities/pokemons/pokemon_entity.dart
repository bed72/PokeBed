import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String name;

  const PokemonEntity({
    required this.name,
  });

  PokemonEntity copyWith({
    String? name,
    String? imageUrl,
  }) =>
      PokemonEntity(
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [
        name,
      ];
}
