import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'datos.dart';

class Lista extends StatefulWidget {
  final List<Item> items;
  const Lista({super.key, required this.items});
  @override
  State<StatefulWidget> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
        backgroundColor: const Color.fromARGB(255, 1, 179, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 230, 228, 228),
      body: items.isEmpty
          ? Center(
              child: Text(
                'Lista Vacia',
                style: TextStyle(color: const Color.fromARGB(208, 244, 67, 54)),
              ),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.production_quantity_limits),
                        title: Text(
                          item.producto,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.descripcion,
                              style: TextStyle(
                                color: const Color.fromARGB(207, 28, 27, 27),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Precio: ${item.precio}',
                              style: TextStyle(
                                color: const Color.fromARGB(207, 28, 27, 27),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: const Color.fromARGB(255, 255, 34, 34),
                          onPressed: () {
                            setState(() {
                              //print('Eliminar $index');
                              items.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
