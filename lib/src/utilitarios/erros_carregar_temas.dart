import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ErrorCarregarEmpresa implements AppErro {
  final String mensagem;
  ErrorCarregarEmpresa({required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}
