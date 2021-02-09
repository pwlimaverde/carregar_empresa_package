import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../utilitarios/erros_carregar_temas.dart';
import 'entities/resultado_empresa.dart';

class CarregarEmpresaUsecase
    extends UseCase<Stream<ResultadoEmpresa>, NoParams> {
  final Repositorio<Stream<ResultadoEmpresa>, NoParams> repositorio;

  CarregarEmpresaUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> call(
      {required NoParams parametros}) async {
    try {
      final resultado = await retornoRepositorio(
        repositorio: repositorio,
        erro: ErrorCarregarEmpresa(
            mensagem: "Erro ao carregar os dados da Empresa Cod.01-1"),
        parametros: NoParams(),
      );
      return resultado;
    } catch (e) {
      return ErroRetorno(
        erro: ErrorCarregarEmpresa(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa Cod.01-2",
        ),
      );
    }
  }
}
