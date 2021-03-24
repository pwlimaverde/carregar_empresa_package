import 'package:return_success_or_error/return_success_or_error.dart';

class ErrorCarregarEmpresa implements AppError {
  String message;
  ErrorCarregarEmpresa({required this.message});

  @override
  String toString() {
    return "ErrorConeccao - $message";
  }
}
