enum ApiStatus { idle, loading, success, error }

class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String? message;

  const ApiResponse._({
    required this.status,
    this.data,
    this.message,
  });

  factory ApiResponse.idle() => const ApiResponse._(status: ApiStatus.idle);
  factory ApiResponse.loading() => const ApiResponse._(status: ApiStatus.loading);
  factory ApiResponse.success(T data) =>
      ApiResponse._(status: ApiStatus.success, data: data);
  factory ApiResponse.error(String message) =>
      ApiResponse._(status: ApiStatus.error, message: message);

  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;
}
