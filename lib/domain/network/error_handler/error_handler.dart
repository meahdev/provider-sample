
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ErrorHandler(this._errorCode, this._errorMessage);

  ErrorHandler.withErrorAndCode({required DioError error}) {
    _handleErrorAndCode(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleErrorAndCode(DioError error) {
    ErrorHandler serverError;

    switch (error.type) {
      case DioErrorType.cancel:
        _errorCode = error.response!.statusCode;
        _errorMessage = "Request was cancelled";
        serverError =  ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.connectTimeout:
        try {
          _errorCode = error.response!.statusCode;
        } catch (e) {
          _errorCode = 101;
        }
        _errorMessage = "Connection timeout";
        serverError =  ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.receiveTimeout:
        _errorCode = error.response != null ? error.response!.statusCode : 500;
        _errorMessage = "Receive timeout in connection";
        serverError =  ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.response:
        _errorCode = error.response!.statusCode;
        if(_errorCode == 401){

        }

        if (error.response != null && error.response!.statusMessage!.isNotEmpty) {
          try {
            _errorMessage = error.response!.data['message'].toString();
          } catch (e) {
            _errorMessage =
            "Received invalid status code: ${error.response!.statusCode}";
          }
        } else {
          _errorMessage =
          "Received invalid status code: ${error.response!.statusCode}";
        }
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.sendTimeout:
        _errorCode = error.response!.statusCode;
        _errorMessage = "Receive timeout in send request";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.other:
        _errorCode = 100;
        _errorMessage = "Connection failed due to internet connection";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      default:
        _errorCode = error.response!.statusCode;
        _errorMessage = error.response!.statusMessage!;
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
    }
    return serverError;
  }
}