extension FunctionFuture<T> on Future<T> {
  Future<V> map<V>(V Function(T) f) => this.then((value) => f(value));

  Future<V> flatMap<V>(Future<V> Function(T) f) =>
      this.then((value) => f(value));
}
