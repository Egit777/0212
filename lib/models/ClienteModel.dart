class ClienteModel {
  String data;
  String nomePosto;
  String kmAnterior;
  String kmAtual;
  String precoLitro;
  String precoAbastecido;
  String quantidadeLitros;
  String kmRodado;
  String precoKm;

  ClienteModel({
    required this.data,
    required this.nomePosto,
    required this.kmAnterior,
    required this.kmAtual,
    required this.precoLitro,
    required this.precoAbastecido,
    required this.quantidadeLitros,
    required this.kmRodado,
    required this.precoKm,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'nomePosto': nomePosto,
      'kmAnterior': kmAnterior,
      'kmAtual': kmAtual,
      'precoLitro': precoLitro,
      'precoAbastecido': precoAbastecido,
      'quantidadeLitros': quantidadeLitros,
      'kmRodado': kmRodado,
      'precoKm': precoKm,
    };
  }
}
