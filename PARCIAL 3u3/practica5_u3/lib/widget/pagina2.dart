import 'package:flutter/material.dart';

class Pagina2 extends StatefulWidget {
  final String nombre;
  const Pagina2({super.key, required this.nombre});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Pagina2> {
  late String dato;
  @override
  void initState() {
    super.initState();
    dato = "El nombre es ${widget.nombre}";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(child: Text('$dato')),
    );
  }
}
