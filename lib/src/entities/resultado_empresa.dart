class ResultadoEmpresa {
  final String nome;
  final String logo260x200;
  final bool licenca;

  ResultadoEmpresa({
    required this.nome,
    required this.logo260x200,
    required this.licenca,
  });

  @override
  String toString() {
    return "Empresa => $nome - Ativa => $licenca ";
  }
}
