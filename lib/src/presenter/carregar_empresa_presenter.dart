import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../entities/resultado_empresa.dart';

class CarregarEmpresaPresenter {
  final Datasource<Stream<ResultadoEmpresa>, ParametrosRetornoResultado>
      datasource;
  final bool mostrarTempoExecucao;

  CarregarEmpresaPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>>
      carregarEmpresa() async {
    final resultado = await RetornoResultadoPresenter<Stream<ResultadoEmpresa>>(
      mostrarTempoExecucao: mostrarTempoExecucao,
      nomeFeature: "Carregar Empresa",
      datasource: datasource,
    ).retornoResultado(
        parametros:
            NoParams(mensagemErro: "Erro ao carregar os dados da Empresa"));
    return resultado;
  }
}
