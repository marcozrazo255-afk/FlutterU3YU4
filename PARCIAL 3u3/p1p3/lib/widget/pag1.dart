import 'package:flutter/material.dart';
import 'package:p1p3/widget/pag2.dart';

class Pag1 extends StatefulWidget {
  const Pag1({super.key});
  @override
  State<StatefulWidget> createState() {
    return Datos();
  }
}

class Datos extends State<Pag1> {
  final _key = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController Apellido = TextEditingController();

  void validar() {
    String non = nombre.text;
    String apel = Apellido.text;
    String cadena = non + " - " + apel;
    if (_key.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pag2(cadena: cadena)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error')));
    }
  }

  String? _vNom(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else {
      String letra = value[0];
      if (letra.toLowerCase() != letra) {
        return 'El campo solo puede contener letras';
      } else {
        final nom = RegExp(r'^[a-z]+$');
        if (!nom.hasMatch(value)) {
          return 'El campo solo puede contener letras';
        }
      }
    }
    return null;
  }

  String? _vApell(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else {
      final nom = RegExp(r'^[a-z]+$');
      if (!nom.hasMatch(value)) {
        return 'El campo solo puede contener letras';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pag1")),
      body: Form(
        key: _key,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombre,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: _vNom,
                    ),
                    TextFormField(
                      controller: Apellido,
                      decoration: const InputDecoration(labelText: 'Apellido'),
                      validator: _vApell,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      validar();
                    },
                    child: const Text('click'),
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
