import 'package:carregar_empresa_package/src/presenter/carregar_empresa_presenter.dart';
import 'package:carregar_empresa_package/src/entities/resultado_empresa.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseEmpresaDatasource extends Mock
    implements Datasource<Stream<ResultadoEmpresa>, NoParams> {}

void main() {
  late Datasource<Stream<ResultadoEmpresa>, NoParams> datasource;

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
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
    expect(result, isA<SucessoRetorno<Stream<ResultadoEmpresa>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
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
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<Stream<ResultadoEmpresa>>>());
  });
}
