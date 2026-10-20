// import 'package:dio/dio.dart';
//
// import 'exception.dart';
// import 'server_error_message_mapper.dart';
//
// AppException dioExceptionHandler(DioException exception) {
//   switch (exception.type) {
//     case DioExceptionType.cancel:
//       return ServerException(message: 'Запрос был отменён');
//
//     case DioExceptionType.transformTimeout:
//     case DioExceptionType.connectionTimeout:
//     case DioExceptionType.receiveTimeout:
//     case DioExceptionType.sendTimeout:
//       return ServerException(message: 'Время ожидания запроса истекло');
//
//     case DioExceptionType.connectionError:
//       return NoInternetException(message: 'Не удалось подключиться к серверу');
//
//     case DioExceptionType.badResponse:
//       return _mapBadResponse(exception);
//
//     case DioExceptionType.unknown:
//       return ServerException(message: 'Произошла непредвиденная ошибка');
//
//     case DioExceptionType.badCertificate:
//       return ServerException(message: 'Ошибка сертификата безопасности');
//   }
// }
//
// AppException _mapBadResponse(DioException exception) {
//   final statusCode = exception.response?.statusCode;
//
//   final responseData = exception.response?.data;
//
//   final data = responseData is Map<String, dynamic> ? responseData : null;
//
//   final code = data?['code'] as String?;
//
//   final message = ServerErrorMessageMapper.getMessage(
//     statusCode: statusCode,
//     data: data,
//     code: code,
//   );
//
//   switch (statusCode) {
//     case 401:
//       return UnauthorizedException(message: message);
//
//     default:
//       return ServerException(
//         message: message,
//         statusCode: statusCode,
//         code: code,
//         data: data,
//       );
//   }
// }
