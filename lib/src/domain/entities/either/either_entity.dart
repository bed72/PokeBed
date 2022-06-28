import 'package:bed/src/domain/entities/either/left_entity.dart';
import 'package:bed/src/domain/entities/either/right_entity.dart';

typedef Lazy<T> = T Function();

/// Represents a value of one of two possible types.
/// Instances of [Either] are either an instance of [Left] or [Right].
///
/// [Left] is used for "failure".
/// [Right] is used for "success".
abstract class Either<L, R> {
  const Either();

  /// Represents the left side of [Either] class which by convention is a "Failure".
  bool get isLeft => this is Left<L, R>;

  /// Represents the right side of [Either] class which by convention is a "Success"
  bool get isRight => this is Right<L, R>;

  /// Get [Left] value, may throw an exception when the value is [Right]
  L get left => fold<L>(
      (value) => value,
      (right) => throw Exception(
          'Illegal use. You should check isLeft before calling'));

  /// Get [Right] value, may throw an exception when the value is [Left]
  R get right => fold<R>(
      (left) => throw Exception(
          'Illegal use. You should check isRight before calling'),
      (value) => value);

  /// Transform values of [Left] and [Right]
  Either<TL, TR> either<TL, TR>(
      TL Function(L left) fnL, TR Function(R right) fnR);

  /// Transform value of [Right] when transformation may be finished with an error
  Either<L, TR> then<TR>(Either<L, TR> Function(R right) fnR);

  /// Transform value of [Right] when transformation may be finished with an error
  Future<Either<L, TR>> thenAsync<TR>(
      Future<Either<L, TR>> Function(R right) fnR);

  /// Transform value of [Left] when transformation may be finished with an [Right]
  Either<TL, R> thenLeft<TL>(Either<TL, R> Function(L left) fnL);

  /// Transform value of [Left] when transformation may be finished with an [Right]
  Future<Either<TL, R>> thenLeftAsync<TL>(
      Future<Either<TL, R>> Function(L left) fnL);

  /// Transform value of [Right]
  Either<L, TR> map<TR>(TR Function(R right) fnR);

  /// Transform value of [Left]
  Either<TL, R> mapLeft<TL>(TL Function(L left) fnL);

  /// Transform value of [Right]
  Future<Either<L, TR>> mapAsync<TR>(Future<TR> Function(R right) fnR);

  /// Transform value of [Left]
  Future<Either<TL, R>> mapLeftAsync<TL>(Future<TL> Function(L left) fnL);

  /// Fold [Left] and [Right] into the value of one type
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR);

  /// Swap [Left] and [Right]
  Either<R, L> swap() => fold((left) => Right(left), (right) => Left(right));

  /// Constructs a new [Either] from a function that might throw
  static Either<L, R> tryCatch<L, R, Erro extends Object>(
      L Function(Erro err) onError, R Function() fnR) {
    try {
      return Right(fnR());
    } on Erro catch (error) {
      return Left(onError(error));
    }
  }

  /// If the condition is satify then return [rightValue] in [Right] else [leftValue] in [Left]
  static Either<L, R> cond<L, R>(bool test, L leftValue, R rightValue) =>
      test ? Right(rightValue) : Left(leftValue);

  /// If the condition is satify then return [rightValue] in [Right] else [leftValue] in [Left]
  static Either<L, R> condLazy<L, R>(
          bool test, Lazy<L> leftValue, Lazy<R> rightValue) =>
      test ? Right(rightValue()) : Left(leftValue());
}
