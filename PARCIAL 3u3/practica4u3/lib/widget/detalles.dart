import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detalles extends StatefulWidget {
  final String clave;
  final String nombre;
  final String correo;
  const Detalles({
    super.key,
    required this.clave,
    required this.nombre,
    required this.correo,
  });
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Detalles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text("${widget.clave}", style: TextStyle(fontSize: 15)),
              Text("${widget.nombre}", style: TextStyle(fontSize: 15)),
              Text("${widget.correo}", style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
