import 'package:carregar_empresa_package/src/utilitarios/erros_carregar_temas.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

import '../entities/resultado_empresa.dart';

class CarregarEmpresaPresenter {
  final Datasource<Stream<ResultadoEmpresa>> datasource;
  final bool mostrarTempoExecucao;

  CarregarEmpresaPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<ReturnSuccessOrError<Stream<ResultadoEmpresa>>>
      carregarEmpresa() async {
    final resultado = await ReturnResultPresenter<Stream<ResultadoEmpresa>>(
      showRuntimeMilliseconds: mostrarTempoExecucao,
      nameFeature: "Carregar Empresa",
      datasource: datasource,
    )(
      parameters: NoParams(
        error: ErrorCarregarEmpresa(
            message: "Erro ao carregar os dados da Empresa"),
      ),
    );
    return resultado;
  }
}
