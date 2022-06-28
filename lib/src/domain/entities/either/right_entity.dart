import 'package:bed/src/domain/entities/either/either_entity.dart';

/// Used for "success"
class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  Either<TL, TR> either<TL, TR>(
    TL Function(L left) fnL,
    TR Function(R right) fnR,
  ) =>
      Right<TL, TR>(fnR(value));

  @override
  Either<L, TR> then<TR>(Either<L, TR> Function(R right) fnR) => fnR(value);

  @override
  Future<Either<L, TR>> thenAsync<TR>(
          Future<Either<L, TR>> Function(R right) fnR) =>
      fnR(value);

  @override
  Either<TL, R> thenLeft<TL>(Either<TL, R> Function(L left) fnL) =>
      Right<TL, R>(value);

  @override
  Future<Either<TL, R>> thenLeftAsync<TL>(
          Future<Either<TL, R>> Function(L left) fnL) =>
      Future.value(Right<TL, R>(value));

  @override
  Either<L, TR> map<TR>(TR Function(R right) fnR) => Right<L, TR>(fnR(value));

  @override
  Either<TL, R> mapLeft<TL>(TL Function(L left) fnL) => Right<TL, R>(value);

  @override
  Future<Either<L, TR>> mapAsync<TR>(Future<TR> Function(R right) fnR) =>
      fnR(value).then((value) => Right<L, TR>(value));

  @override
  Future<Either<TL, R>> mapLeftAsync<TL>(Future<TL> Function(L left) fnL) =>
      Future.value(Right<TL, R>(value));

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) => fnR(value);
}
