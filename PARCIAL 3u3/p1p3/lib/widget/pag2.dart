import 'package:flutter/material.dart';

class Pag2 extends StatefulWidget {
  final String cadena;
  const Pag2({super.key, required this.cadena});
  @override
  State<Pag2> createState() {
    return Datos();
  }
}

class Datos extends State<Pag2> {
  @override
  void initState() {
    super.initState();
    int p = widget.cadena.indexOf(" - ");
    String a = widget.cadena.substring(0, p);
    String b = widget.cadena.substring(p + 1);
    //split
    String c = widget.cadena.split(" - ")[0];
  }

  @override
  Widget build(BuildContext context) {
    List<Item> item = [Item('titulo', 'Descripcion')];

    return Scaffold(
      appBar: AppBar(title: const Text("Pag2")),
      body: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(item[index].titulo),
            subtitle: Text(item[index].descripcion),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String titulo;
  final String descripcion;
  Item(this.titulo, this.descripcion);
}
