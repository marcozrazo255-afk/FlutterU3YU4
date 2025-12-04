import 'package:flutter/material.dart';
import 'package:p2p3/widget/pagina3.dart';

class Pagina2 extends StatefulWidget {
  const Pagina2({super.key});

  @override
  State<StatefulWidget> createState() {
    return Datos();
  }
}

class Datos extends State<Pagina2> {
  final _llave = GlobalKey<FormState>();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellidos = TextEditingController();

  void validar() {
    String non = nombre.text;
    String ape = apellidos.text;
    String cadena = non + " - " + ape;

    if (_llave.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pagina3(cadena: cadena)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error')));
    }
  }

  String? _vNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Escribe el nombre';
    }

    String letra = value[0];
    if (letra == value[0].toUpperCase()) {
      final nom = RegExp(r'^[a-z]+$');
      String letras = value.substring(1, value.length);
      print(letras);
      if (!nom.hasMatch(letras)) {
        return 'Error solo minusculas';
      }
    } else {
      return 'La primer letra debe ser mayusculas';
    }
  }

  String? _vApellidos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Escribe el nombre';
    }
    final nom = RegExp(r'^[a-z]+$');
    if (!nom.hasMatch(value)) {
      return 'Error solo minusculas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practica 1'), backgroundColor: Colors.lime),
      body: Form(
        key: _llave,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nombre,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: _vNombre,
                      ),
                      TextFormField(
                        controller: apellidos,
                        decoration: InputDecoration(labelText: 'Apellidos'),
                        validator: _vApellidos,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.lightGreenAccent,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 80),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: validar,
                      child: Text('Aceptar'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
