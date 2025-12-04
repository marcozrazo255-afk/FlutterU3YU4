import 'package:flutter/material.dart';
import 'package:practicaextra/widget/lista.dart';

class Datos extends StatefulWidget {
  const Datos({super.key});
  @override
  State<StatefulWidget> createState() => _DatosState();
}

class Item {
  final String producto;
  final String descripcion;
  final String precio;
  Item(this.producto, this.descripcion, this.precio);
}

class _DatosState extends State<Datos> {
  TextEditingController pre = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController prec = TextEditingController();

  List<Item> items = [];

  void _agregar() {
    setState(() {
      String p = pre.text;
      String d = des.text;
      String pr = prec.text;
      if (p.isNotEmpty || d.isNotEmpty || pr.isNotEmpty) {
        items.add(Item(p, d, pr));
        pre.clear();
        des.clear();
        prec.clear();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Datos agregados a la lista")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Faltan datos")));
      }
    });
  }

  void _enviar() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lista(items: items)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos'),
        backgroundColor: const Color.fromARGB(255, 13, 248, 237),
        actions: [IconButton(onPressed: _enviar, icon: Icon(Icons.list))],
      ),
      backgroundColor: const Color.fromARGB(255, 221, 223, 219),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    controller: pre,
                    decoration: InputDecoration(
                      labelText: 'Escribe el producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: des,
                    decoration: InputDecoration(
                      labelText: 'Escribe la descripcion',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: prec,
                    decoration: InputDecoration(
                      labelText: 'Escribe el precio',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _agregar,
                      label: Text('Agregar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
