import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../carregar_temas_package.dart';
import '../utilitarios/erros_carregar_temas.dart';

class CarregarTemasRepositorio
    extends Repositorio<Stream<ResultadoTheme>, NoParams> {
  final Datasource<Stream<ResultadoTheme>, NoParams> datasource;

  CarregarTemasRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> call(
      {required NoParams parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErrorCarregarTemas(
        mensagem: "Erro ao carregar os dados tema Cod.02-1",
      ),
      parametros: NoParams(),
    );
    return resultado;
  }
}
