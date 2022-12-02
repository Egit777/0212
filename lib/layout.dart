import 'package:flutter/material.dart';
import 'Database/BancoDados.dart';
import 'package:Minha_Gazoza/Home.dart';
import 'package:Minha_Gazoza/historico.dart';
import 'package:Minha_Gazoza/telaCalculo.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    TelaCalculo(),
    Home(),
    MyTable(
      dadosTabela: [],
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_view),
            label: 'Tabela',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.tealAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
