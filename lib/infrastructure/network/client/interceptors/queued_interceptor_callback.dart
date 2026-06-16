import 'package:dio/dio.dart';

/// Callback wrapper for queued requests during token refresh
/// This class holds the request handler and allows it to be resolved or rejected
/// after the token refresh operation completes
class QueuedInterceptorCallback {
  final ErrorInterceptorHandler _handler;
  final RequestOptions _requestOptions;
  final DateTime queuedAt;
  final String? correlationId;

  QueuedInterceptorCallback(
    this._handler,
    this._requestOptions,
    this.correlationId,
    this.queuedAt,
  );

  /// Resolve the queued request with a response
  void resolve(Response response) {
    _handler.resolve(response);
  }

  /// Reject the queued request with an error
  void reject(DioException error) {
    _handler.reject(error);
  }

  /// Get the original request options
  RequestOptions get requestOptions => _requestOptions;

  /// Check if the callback is still valid (not already resolved/rejected)
  bool get isValid => _handler.isCompleted == false;

  /// Get the time this request has been waiting in queue
  Duration get waitingDuration => DateTime.now().difference(queuedAt);

  @override
  String toString() {
    return 'QueuedInterceptorCallback(request: ${_requestOptions.method} ${_requestOptions.path}, isValid: $isValid), correlationId: $correlationId, queuedAt: $queuedAt';
  }
}
