import 'package:carregar_empresa_package/src/presenter/carregar_empresa_presenter.dart';
import 'package:carregar_empresa_package/src/entities/resultado_empresa.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:return_success_or_error/return_success_or_error.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseEmpresaDatasource extends Mock
    implements Datasource<Stream<ResultadoEmpresa>> {}

void main() {
  late Datasource<Stream<ResultadoEmpresa>> datasource;

  setUp(() {
    datasource = FairebaseEmpresaDatasource();
  });

  test('Deve retornar um sucesso com Stream<ResultadoEmpresa>', () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(
      ResultadoEmpresa(
        nome: "VorFast",
        logo260x200: "logo",
        licenca: true,
      ),
    );
    when(datasource).calls(#call).thenAnswer((_) => Future.value(testeFire));
    final result = await CarregarEmpresaPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarEmpresa();
    print("teste result - ${await result.fold(
          success: (value) => value.result,
          error: (value) => value.error,
        ).first}");
    expect(result, isA<SuccessReturn<Stream<ResultadoEmpresa>>>());
    expect(
        result.fold(
          success: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<Stream<ResultadoEmpresa>>());
    testeFire.close();
  });

  test(
      'Deve ErrorCarregarEmpresa com Erro ao carregar os dados da empresa Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarEmpresaPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarEmpresa();
    print("teste result - ${await result.fold(
      success: (value) => value.result,
      error: (value) => value.error,
    )}");
    expect(result, isA<ErrorReturn<Stream<ResultadoEmpresa>>>());
  });
}
