import 'package:flutter/material.dart';
import 'package:practica5_u3/widget/pagina2.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Pagina1> {
  TextEditingController nombre = TextEditingController();

  void _enviar() {
    final String n = nombre.text;
    setState(() {
      if (n.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pagina2(nombre: n)),
        );
      } else {
        print('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nombre,
                decoration: InputDecoration(labelText: "Escribe un nombre"),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _enviar,
                  child: Text("Enviar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
