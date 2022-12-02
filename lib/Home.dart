import 'package:flutter/material.dart';
import 'sobrenos.dart';

class Home extends StatefulWidget {
  const Home({key});

  static const String _title = 'Flutter Code Sample';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Home._title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Sobrenos()),
                );
              },
              icon: Icon(Icons.info)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 140,
            ),
            Container(
              height: 500,
              child: Image.asset('assets/images/LogoApp.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BEM VINDO',
                  style: TextStyle(fontSize: 60, color: Colors.blue[900]),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
