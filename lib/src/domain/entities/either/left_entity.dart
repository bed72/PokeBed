import 'package:bed/src/domain/entities/either/either_entity.dart';

/// Used for "failure"
class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  Either<TL, TR> either<TL, TR>(
    TL Function(L left) fnL,
    TR Function(R right) fnR,
  ) =>
      Left<TL, TR>(fnL(value));

  @override
  Either<L, TR> then<TR>(
    Either<L, TR> Function(R right) fnR,
  ) =>
      Left<L, TR>(value);

  @override
  Future<Either<L, TR>> thenAsync<TR>(
    Future<Either<L, TR>> Function(R right) fnR,
  ) =>
      Future.value(Left<L, TR>(value));

  @override
  Either<TL, R> thenLeft<TL>(Either<TL, R> Function(L left) fnL) => fnL(value);

  @override
  Future<Either<TL, R>> thenLeftAsync<TL>(
          Future<Either<TL, R>> Function(L left) fnL) =>
      fnL(value);

  @override
  Either<L, TR> map<TR>(TR Function(R right) fnR) => Left<L, TR>(value);

  @override
  Either<TL, R> mapLeft<TL>(TL Function(L left) fnL) => Left<TL, R>(fnL(value));

  @override
  Future<Either<L, TR>> mapAsync<TR>(Future<TR> Function(R right) fnR) =>
      Future.value(Left<L, TR>(value));

  @override
  Future<Either<TL, R>> mapLeftAsync<TL>(Future<TL> Function(L left) fnL) =>
      fnL(value).then((value) => Left<TL, R>(value));

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) => fnL(value);
}
