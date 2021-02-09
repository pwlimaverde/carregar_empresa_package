import 'package:carregar_empresa_package/src/repositories/carregar_empresa_repository.dart';
import 'package:carregar_empresa_package/src/usecases/carregar_empresa_usecase.dart';
import 'package:carregar_empresa_package/src/usecases/entities/resultado_empresa.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseEmpresaDatasource extends Mock
    implements Datasource<Stream<ResultadoEmpresa>, NoParams> {}

void main() {
  late Datasource<Stream<ResultadoEmpresa>, NoParams> datasource;
  late Repositorio<Stream<ResultadoEmpresa>, NoParams> repositorio;
  late UseCase<Stream<ResultadoEmpresa>, NoParams> carregarEmpresaUsecase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    datasource = FairebaseEmpresaDatasource();
    repositorio = CarregarEmpresaRepositorio(datasource: datasource);
    carregarEmpresaUsecase = CarregarEmpresaUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com true', () async {
    tempo.iniciar();
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(
      ResultadoEmpresa(
        nome: "VorFast",
        logo260x200: "logo",
        licenca: true,
      ),
    );
    when(datasource).calls(#call).thenAnswer((_) => Future.value(testeFire));
    final result = await carregarEmpresaUsecase(parametros: NoParams());
    print("teste result - ${await result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
    tempo.terminar();
    print(
        "Tempo de Execução do CarregarEmpresa: ${tempo.calcularExecucao()}ms");
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
    tempo.iniciar();
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(
      ResultadoEmpresa(
        nome: "VorFast",
        logo260x200: "logo",
        licenca: true,
      ),
    );
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await carregarEmpresaUsecase(parametros: NoParams());
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print(
        "Tempo de Execução do CarregarEmpresa: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<Stream<ResultadoEmpresa>>>());
    testeFire.close();
  });
}
