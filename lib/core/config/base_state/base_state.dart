class BaseState<T> {
  bool? isLoading;
  T? data;
  String? errorMessage;

  BaseState({
    this.isLoading,
    this.data,
    this.errorMessage,
  });
}
