part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A class of errors that can occur when using the MapsIndoors SDK
class MPError {
  /// Occurs when an internet connection is required, or if the content server is unresponsive
  static const int networkError = 10;

  /// Occurs if an unknown exception is caught
  static const int unknownError = 20;

  /// Occurs if some functions are called before the SDK has been initialized
  static const int sdkNotInitialized = 22;

  /// Occurs if the supplied API key is not a valid MapsIndoors key
  static const int invalidApiKey = 100;

  /// The error's [code]
  late final int code;

  /// A [message] that describes the context of the error
  late final String message;

  /// An optional [status], if the error is a [networkError], this will be the HTTP response code
  late final int? status;

  /// An optional tag
  late final Object? tag;

  MPError({required this.code, required this.message, this.status, this.tag});

  static MPError? fromJson(json) => json != null && json != "null"
      ? MPError._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPError._fromJson(data) {
    code = data["code"];
    message = data["message"];
    status = data["status"];
    tag = data["tag"];
  }

  @override
  bool operator ==(Object other) => (other is MPError &&
      other.runtimeType == runtimeType &&
      other.code == code);

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() {
    return "code: $code, message: \"$message\"" +
        ((status != null) ? ", status: $status" : "") +
        ((tag != null) ? ", tag: $tag" : "");
  }
}
