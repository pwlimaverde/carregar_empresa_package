import 'package:carregar_empresa_package/src/usecases/carregar_empresa_usecase.dart';
import 'package:carregar_empresa_package/src/usecases/entities/resultado_empresa.dart';
import 'package:carregar_empresa_package/src/utilitarios/erros_carregar_temas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class CarregarEmpresaRepositorioMock extends Mock
    implements Repositorio<Stream<ResultadoEmpresa>, NoParams> {}

void main() {
  late Repositorio<Stream<ResultadoEmpresa>, NoParams> repositorio;
  late UseCase<Stream<ResultadoEmpresa>, NoParams> carregarEmpresaUsecase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    repositorio = CarregarEmpresaRepositorioMock();
    carregarEmpresaUsecase = CarregarEmpresaUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com Stream<ResultadoEmpresa>', () async {
    tempo.iniciar();
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(
      ResultadoEmpresa(
        nome: "VorFast",
        logo260x200: "logo",
        licenca: true,
      ),
    );
    when(repositorio).calls(#call).thenAnswer((_) => Future.value(
        SucessoRetorno<Stream<ResultadoEmpresa>>(resultado: testeFire)));
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
      'Deve retornar um ErrorCarregarEmpresa com Erro ao carregar os dados da empresa Cod.01-1',
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
    when(repositorio).calls(#call).thenAnswer(
          (_) => Future.value(
            ErroRetorno<Stream<ResultadoEmpresa>>(
              erro: ErrorCarregarEmpresa(
                mensagem: "Erro ao carregar os dados da empresa Cod.01-1",
              ),
            ),
          ),
        );
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

  test(
      'Deve retornar um ErrorCarregarEmpresa com Erro ao carregar os dados da empresa Cod.01-1',
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
    when(repositorio).calls(#call).thenThrow(Exception());
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
