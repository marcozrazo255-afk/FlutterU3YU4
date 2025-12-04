import 'package:flutter/material.dart';

class Pagina3 extends StatefulWidget {
  final String cadena;
  const Pagina3({super.key, required this.cadena});
  @override
  State<StatefulWidget> createState() {
    return Clases();
  }
}

class Item {
  final String titulo;
  final String descripcion;
  Item(this.titulo, this.descripcion);
}

class Clases extends State<Pagina3> {
  List<Item> items = [Item('titulo', 'descripcion')];
  void agregar() {
    setState(() {
      int indexLista = items.length + 1;
      items.add(Item('titulo $indexLista', 'descripcion $indexLista'));
    });
  }

  String a = "";
  String p1 = "";
  @override
  void initState() {
    super.initState();
    int p = widget.cadena.indexOf(" - ");
    a = widget.cadena.substring(0, p);
    p1 = widget.cadena.substring(p + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("${a}", style: TextStyle(color: Colors.white)),
            Text("${p1}", style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(items[index].titulo),
            subtitle: Text(items[index].descripcion),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregar,
        child: Icon(Icons.add),
      ),
    );
  }
}
