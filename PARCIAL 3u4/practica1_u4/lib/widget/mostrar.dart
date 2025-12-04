import 'package:flutter/material.dart';
import 'package:practica1_u4/widget/basedatos/basedatoshelper.dart';

class Mostrar extends StatefulWidget {
  const Mostrar({super.key});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Mostrar> {
  List<Map<String, dynamic>> usuarios = [];
  String nombre = "";
  int color1 = 0;
  int color2 = 0;
  int color3 = 0;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    List<Map<String, dynamic>> datos = await Basedatoshelper().obtenerUsuario();
    setState(() {
      usuarios = datos;
    });
    print("Usuarios cargados: ${usuarios}");
  }

  void eliminar(int id) async {
    await Basedatoshelper().eliminar(id);
    cargarDatos();
  }

  void _eliminar(int id) {
    eliminar(id);
  }

  void _modificar(int id, String usuario, String password) {
    TextEditingController usuarionuevo = TextEditingController();
    TextEditingController passwordnuevo = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usuarionuevo,
                  decoration: InputDecoration(labelText: '${usuario}'),
                ),
                TextField(
                  controller: passwordnuevo,
                  decoration: InputDecoration(labelText: 'Escribe el password'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Basedatoshelper().modificar(
                  id,
                  usuarionuevo.text,
                  passwordnuevo.text,
                );
                cargarDatos();
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar datos'),
        backgroundColor: Colors.limeAccent,
      ),
      body: usuarios.isEmpty
          ? Center(child: Text('Base de datos vacía'))
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                nombre = usuarios[index]['usuario'][0];
                return ListTile(
                  leading: CircleAvatar(
                    //backgroundColor:  Color.fromARGB(0, 0, 0, 0),
                    child: Text(
                      nombre.toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  title: Text(usuarios[index]['usuario']),
                  subtitle: Text(usuarios[index]['password']),
                  trailing: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      IconButton(
                        onPressed: () {
                          _eliminar(usuarios[index]['id']);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          _modificar(
                            usuarios[index]['id'],
                            usuarios[index]['usuario'],
                            usuarios[index]['password'],
                          );
                        },
                        icon: Icon(Icons.update),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}


