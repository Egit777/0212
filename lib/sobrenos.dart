import 'package:flutter/material.dart';
import 'Home.dart';
import 'telaCalculo.dart';

class Sobrenos extends StatelessWidget {
  const Sobrenos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SOBRE NÓS'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: 350,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/LogoApp.png',
                      width: 76,
                      height: 76,
                    ),
                    Text(
                      '\r\r Somos um grupo de estudantes e estamos no \n\n último ano da escola, iniciamos o curso em \n\n 2020 na ETEC Antônio Furlan. No início \n\n de 2022, entramos com o projeto de TCC \n\n “Gestão de combustível”. Com esse projeto, \n\n temos o objetivo de ajudar a fazer cálculos \n\n mais rápidos e a controlar os gastos de\n\n consumo do usuário.\n\n\n',
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            '\r\r Alef Barbosa\n Bruno Gomes\n Caio Nascimento\n David Pereira\n João Barros',
                            style: TextStyle(color: Colors.blue[900])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
              ),
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}







//Somos um grupo de estudantes e estamos no último ano da escola, começamos o curso no começo de 2020 na ETEC Antônio Furlan. No início de 2022, entramos com o projeto de TCC “Gestão de combustível”. Com esse projeto, temos o objetivo de ajudar a fazer cálculos mais rápidos e a controlar os gastos de consumo do usuário.