import 'package:Minha_Gazoza/historico.dart';
import 'package:Minha_Gazoza/models/ClienteModel.dart';
import 'Database/BancoDados.dart';
import 'package:flutter/material.dart';

class TelaCalculo extends StatefulWidget {
  const TelaCalculo({Key? key}) : super(key: key);

  @override
  State<TelaCalculo> createState() => _TelaCalculoState();
}

// Controles //
class _TelaCalculoState extends State<TelaCalculo> {
  final TextEditingController _controllerDias = TextEditingController();
  final TextEditingController _controllerNomePosto = TextEditingController();
  final TextEditingController _controllerKmAnterior = TextEditingController();
  final TextEditingController _controllerKmAtual = TextEditingController();
  final TextEditingController _controllerValorLitros = TextEditingController();
  final TextEditingController _controllerValorAbastecido =
      TextEditingController();

  void initState() {
    super.initState();
    quantidadeLitros = "Litros abastecidos";
    kmRodado = "Km rodados";
    precoKm = "Gasto por km";
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DataRow> dadosTabela = [
    const DataRow(
      cells: <DataCell>[
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
    ),
  ];

  void _resetDados() {
    _controllerDias.text = "";
    _controllerNomePosto.text = "";
    _controllerKmAnterior.text = "";
    _controllerKmAtual.text = "";
    _controllerValorLitros.text = "";
    _controllerValorAbastecido.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
      quantidadeLitros = "";
      kmRodado = "";
      precoKm = "";
    });
  }

  void chamarDialogo() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text('Deseja calcular?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Não'),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context, 'Calcular');
                quantidadeLitros = calculoQuantidadeLitros(
                  double.parse(_controllerValorAbastecido.text),
                  double.parse(_controllerValorLitros.text),
                );
                kmRodado = calculoKmRodado(
                  double.parse(_controllerKmAnterior.text),
                  double.parse(_controllerKmAtual.text),
                );
                precoKm = calculoPrecoKm(
                  double.parse(_controllerValorAbastecido.text),
                  double.parse(kmRodado!),
                );
              });
            },
            child: const Text('Calcular'),
          ),
        ],
      ),
    );
  }

  salvarCliente() async {
    ClienteModel cliente = ClienteModel(
      data: _controllerDias.text,
      nomePosto: _controllerNomePosto.text,
      kmAnterior: _controllerKmAnterior.text,
      kmAtual: _controllerKmAtual.text,
      precoLitro: _controllerValorLitros.text,
      precoAbastecido: _controllerValorAbastecido.text,
      quantidadeLitros: quantidadeLitros!,
      kmRodado: kmRodado!,
      precoKm: precoKm!,
    );
    cliente.data = _controllerDias.text;
    cliente.nomePosto = _controllerNomePosto.text;
    cliente.kmAnterior = _controllerKmAnterior.text;
    cliente.kmAtual = _controllerKmAtual.text;
    cliente.precoLitro = _controllerValorLitros.text;
    cliente.precoAbastecido = _controllerValorAbastecido.text;
    cliente.quantidadeLitros = quantidadeLitros!;
    cliente.kmRodado = kmRodado!;
    cliente.precoKm = precoKm!;

    var retorno = await BancoDados.inserirnoBanco(cliente);
  }

  String? quantidadeLitros;
  String? kmRodado;
  String? precoKm;

  // Function calculoQuantidadeLitros
  String? calculoQuantidadeLitros(
      double _controllerValorAbastecido, double _controllerValorLitros) {
    double testeTre = (_controllerValorAbastecido / _controllerValorLitros);

    return testeTre.toString();
  }

// Function calculoKmRodado
  String? calculoKmRodado(
      double _controllerKmAnterior, double _controllerKmAtual) {
    double resultadoKmRodado = (_controllerKmAtual - _controllerKmAnterior);

    return resultadoKmRodado.toString();
  }

  String? calculoPrecoKm(double _controllerValorAbastecido, double kmRodado) {
    double precoKm = _controllerValorAbastecido / kmRodado;

    return precoKm.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('CALCULO'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _resetDados, icon: Icon(Icons.refresh)),
        ],
      ),
      body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Row(children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.blue[900],
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _controllerDias,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira a Data';
                              }
                              return null;
                            },
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.calendar_month),
                                hintText: 'Informe o dia'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerNomePosto,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o Endereço';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.location_on),
                            hintText: 'Endereço'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerKmAnterior,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o KmAnterior';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.speed),
                            hintText: 'KM Anterior'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerKmAtual,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o km atual';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.speed_outlined),
                            hintText: 'KM atual'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerValorLitros,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o preço por litro';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.ev_station),
                            hintText: 'Preço por litro'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerValorAbastecido,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira preço total do abastecimento';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.money),
                            hintText: 'Preço total do abastecimento'),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.blue[900],
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      enabled: false,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.card_travel),
                          hintText: quantidadeLitros),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.blue[900],
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      enabled: false,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.money_off_rounded),
                          hintText: kmRodado),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.blue[900],
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      enabled: false,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.verified_rounded),
                          hintText: precoKm),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              chamarDialogo();
                            }
                          },
                          icon: Icon(Icons.calculate),
                          label: Text('Calcular'),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                          ),
                          onPressed: () async {
                            await salvarCliente();
                            dadosTabela.add(
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(_controllerDias.text)),
                                  DataCell(Text(_controllerNomePosto.text)),
                                  DataCell(Text(_controllerKmAtual.text)),
                                  DataCell(Text(_controllerKmAnterior.text)),
                                  DataCell(
                                      Text(_controllerValorAbastecido.text)),
                                  DataCell(Text(_controllerValorLitros.text)),
                                  DataCell(Text(quantidadeLitros!)),
                                  DataCell(Text(kmRodado!)),
                                  DataCell(Text(precoKm!)),
                                ],
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTable(
                                        dadosTabela: dadosTabela,
                                      )),
                            );
                          },
                          icon: Icon(Icons.calculate),
                          label: Text('Enviar para Tabela'),
                        ),
                      ]),
                ]),
              ),
            ]),
          )),
    );
  }
}
