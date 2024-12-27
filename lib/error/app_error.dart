import 'package:dio/dio.dart';

class AppError {
  final String message;
  final int? code;

  AppError({required this.message, this.code});

  factory AppError.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return AppError(message: "Veuillez verifier votre connexion internet", code: 1001);
      case DioExceptionType.sendTimeout:
        return AppError(message: "Temps d'envoi dans la connexion avec le serveur API expiré.", code: 1002);
      case DioExceptionType.receiveTimeout:
        return AppError(message: "Temps de réception dans la connexion avec le serveur API expiré.", code: 1003);
      case DioExceptionType.badResponse:
          if (error.response!.statusCode == 404) {
            return AppError(
              message:
              "La ressource n'a pas été trouvée.",
              code: error.response?.statusCode,
            );
          } else if (error.response!.statusCode == 401) {
            return AppError(
              message:
              "Accès non autorisé.",
              code: error.response?.statusCode,
            );
          } else if (error.response!.statusCode == 420) {
            return AppError(
              message: "Limite de vitesse dépassée. Veuillez réessayer plus tard.",
              code: error.response?.statusCode,
            );
          }
          else {
            return AppError(
              message:
              "Erreur du serveur : ${error.response?.statusCode ?? 'Inconnue'}.",
              code: error.response?.statusCode,
            );
          }
      case DioExceptionType.cancel:
        return AppError(message: "La demande au serveur API a été annulée.", code: 1004);
      default:
        return AppError(
          message: "Erreur de réseau inconnue.",
          code: 1000,
        );
    }
  }

  factory AppError.generic(String message) {
    return AppError(message: message, code: 1000);
  }

  factory AppError.formatException() {
    return AppError(message: "Données mal formatées.", code: 1002);
  }
}
