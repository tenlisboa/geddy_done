abstract class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.error(Exception value) = Error._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Error<T> extends Result<T> {
  const Error._(this.value);

  final Exception value;

  @override
  String toString() => 'Result<$T>.error($value)';
}

extension ResultExtension on Object {
  Result ok() => Result.ok(this);
}

extension ResultException on Exception {
  Result error() => Result.error(this);
}

extension ResultCasting<T> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;
}

extension ResultErrorCasting<T> on Result<T> {
  Error<T> get asError => this as Error<T>;
}
