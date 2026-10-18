class ServerErrorMessageMapper {
  const ServerErrorMessageMapper._();

  static String getMessage({
    required int? statusCode,
    required Map<String, dynamic>? data,
    required String? code,
  }) {
    if (data != null) {
      final errors = data['errors'];

      if (errors is List && errors.isNotEmpty) {
        return errors
            .map((error) => translate(error.toString()) ?? error.toString())
            .join('\n');
      }

      final message =
          data['detail'] as String? ??
          data['message'] as String? ??
          data['title'] as String?;

      return _getMessageByStatusCode(
        statusCode: statusCode,
        message: message,
        code: code,
      );
    }

    return _getMessageByStatusCode(
      statusCode: statusCode,
      message: null,
      code: code,
    );
  }

  static String _getMessageByStatusCode({
    required int? statusCode,
    required String? message,
    required String? code,
  }) {
    switch (statusCode) {
      case 400:
        return translate(message) ?? 'Неверный запрос';

      case 401:
        return translate(message) ?? 'Ошибка авторизации';

      case 403:
        if (code == 'ACCOUNT_DELETED') {
          return message ?? 'Аккаунт удалён';
        }

        if (code == 'ACCOUNT_BLOCKED') {
          return message ?? 'Аккаунт заблокирован';
        }

        return translate(message) ?? 'Доступ запрещён';

      case 404:
        return translate(message) ?? 'Данные не найдены';

      case 409:
        return translate(message) ?? 'Такие данные уже существуют';

      case 413:
        return translate(message) ?? 'Размер файла не должен превышать 5 MB';

      case 500:
        return translate(message) ?? 'Ошибка на сервере';

      default:
        return translate(message) ?? 'Что-то пошло не так';
    }
  }

  static String? translate(String? message) {
    if (message == null) {
      return null;
    }

    final normalized = message.trim().toLowerCase();

    if (normalized.contains('user with phone number') &&
        normalized.contains('not found')) {
      return 'Пользователь с таким номером '
          'телефона не зарегистрирован';
    }

    switch (normalized) {
      case 'invalid credentials':
        return 'Телефон или пароль неверны';

      case 'user not found':
        return 'Пользователь не найден';

      case 'email already in use':
        return 'Этот email уже зарегистрирован';

      case 'invalid otp code':
      case 'otp code is invalid':
        return 'Код неверный или срок действия истёк';

      case 'unauthorized':
        return 'Требуется авторизация';

      default:
        return message;
    }
  }
}
