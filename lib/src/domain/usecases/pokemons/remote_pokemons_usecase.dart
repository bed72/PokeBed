import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';
import 'package:bed/src/domain/entities/pokemons/pokemons_entity.dart';

abstract class PokemonsUseCase {
  Future<Either<HttpExceptionEntity, PokemonsEntity>> call(
    PokemonsParams params,
  );
}

class PokemonsParams {
  late final String url;

  PokemonsParams({required this.url});
}
