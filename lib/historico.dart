// ignore_for_file: prefer_const_constructor
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:Minha_Gazoza/Home.dart';
import 'package:Minha_Gazoza/layout.dart';
import 'Database/BancoDados.dart';
import 'models/ClienteModel.dart';
import 'telaCalculo.dart';
import 'main.dart';

const Color darkBlue = Color.fromARGB(255, 255, 255, 255);

class MyTable extends StatefulWidget {
  final List<DataRow>? dadosTabela;

  @override
  const MyTable({
    required this.dadosTabela,
  });

  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<Map> listalocal = [];
  //funcoes
  carregarLista() async {
    listalocal = await BancoDados.listartabelas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: carregarLista(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text("Fudeu geral!!!!");
              } else {
                return form(context);
              }
          }
        });

    //Scaffold(
    //   appBar: AppBar(
    //     title: const Text("HISTÓRICO"),
    //     centerTitle: true,
    //     backgroundColor: Colors.blue[900],
    //   ),
    //   body: ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: listalocal.length,
    //       itemBuilder: (context, index) => DataTable(
    //               columns: const <DataColumn>[
    //                 DataColumn(label: Expanded(child: Text("data")))
    //               ],
    //               rows: widget.dadosTabela!)),
    // );

    // body: ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(1.0),
    //       child: Column(
    //         children: [
    //           DataTable(columns: const <DataColumn>[
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'DATA',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'ENDEREÇO',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'KM ATUAL',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'KM ANTERIOR',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'VALOR ABASTECIDO',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'VALOR POR LITRO',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'LITROS ABASTECIDOS',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'KM RODADOS',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //             DataColumn(
    //               label: Expanded(
    //                 child: Text(
    //                   'CONSUMO POR KM',
    //                   style: TextStyle(fontStyle: FontStyle.italic),
    //                 ),
    //               ),
    //             ),
    //           ], rows: widget.dadosTabela!),
    //           ElevatedButton(
    //               onPressed: () {
    //
    //               },
    //               child: Text('Home'))
    //         ],
    //       ),
    //     ),
    //   ],
    // )),
  }

  Widget form(context) {
    ScrollController listscroll = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("HISTÓRICO"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Layout()));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
                controller: listscroll,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listalocal.length,
                itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(listalocal[index]["data"]),
                              subtitle: Text(listalocal[index]["nomePosto"]),
                            ),
                            Text(
                              (listalocal[index]["kmAnterior"].toString()),
                            ),
                            Text(
                              (listalocal[index]["kmAtual"].toString()),
                            ),
                            Text(
                              (listalocal[index]["precoLitro"].toString()),
                            ),
                            Text(
                              (listalocal[index]["precoAbastecido"].toString()),
                            ),
                            Text(
                              (listalocal[index]["quantidadeLitros"]
                                  .toString()),
                            ),
                            Text(
                              (listalocal[index]["kmRodado"].toString()),
                            ),
                            Text(
                              (listalocal[index]["precoKm"].toString()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                    ),
                                    onPressed: () async {
                                      int a = listalocal[index]["id"];
                                      var retorno =
                                          await BancoDados.deleteMemo(a);
                                      setState(() {});
                                    },
                                    child: Text('Deletar')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

//  return SingleChildScrollView(
//     child: Column(
//       children: [
//         ListView.builder(
//             shrinkWrap: true,
//             itemCount: listalocal.length,
//             itemBuilder: (context, index) =>
//                 DataTable(columns: const <DataColumn>[
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                   DataColumn(label: Expanded(child: Text("data"))),
//                 ], rows:  List<DataRow> listaderows = [
//         DataRow(
//                   cells: <DataCell>[
//         DataCell(Text(listalocal[index]["data"])),
//         DataCell(Text(listalocal[index]["nomePosto"])),
//         DataCell(Text(listalocal[index]["kmAnterior"])),
//         DataCell(Text(listalocal[index]["kmAtual"])),
//         DataCell(Text(listalocal[index]["precoLitro"])),
//         DataCell(Text(listalocal[index]["precoAbastecido"])),
//         DataCell(Text(listalocal[index]["quantidadeLitros"])),
//         DataCell(Text(listalocal[index]["kmRodado"])),
//         DataCell(Text(listalocal[index]["precoKm"])),
//       ],
//     ),
//                 ]),),

//       ],
//     ),
//   );
