import 'package:bed/src/data/models/pokemons/pokemons_model.dart';

import 'package:bed/src/domain/usecases/http/http_usecase.dart';
import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';
import 'package:bed/src/domain/entities/pokemons/pokemons_entity.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

class RemotePokemonsUseCase implements PokemonsUseCase {
  late final HttpUseCase _httpUseCase;

  RemotePokemonsUseCase(this._httpUseCase);

  @override
  Future<Either<HttpExceptionEntity, PokemonsEntity>> call(
    PokemonsParams params,
  ) async {
    final response = await _httpUseCase.get(url: params.url);

    return response.either(
      (left) => left,
      (right) => PokemonsModel.fromJson(right),
    );
  }
}
