import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrsqlite/basedatos.dart/basedatoshelper.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Pagina1> {
  // 1) Bandera para evitar abrir múltiples diálogos al detectar varios frames del QR.
  bool ventana = false;

  // 2) Controladores creados una sola vez y limpiados en dispose para evitar fugas de memoria.
  final TextEditingController nombre = TextEditingController();
  final TextEditingController precio = TextEditingController();

  @override
  void dispose() {
    // 3) Liberar recursos al cerrar la pantalla.
    nombre.dispose();
    precio.dispose();
    super.dispose();
  }

  // 4) Utilidad: limpiar campos antes de mostrar el diálogo.
  void _limpiarCampos() {
    nombre.clear();
    precio.clear();
  }

  // 5) Diálogo para capturar datos; recibe el código QR como 'numeros'.
  Future<void> _mostrarDatos(String numeros) async {
    _limpiarCampos(); // 5.1) Asegurar campos en blanco al abrir.

    // 5.2) showDialog devuelve un Future; esperamos (await) para saber cuándo cerrar y poder resetear 'ventana'.
    await showDialog(
      context: context,
      barrierDismissible:
          false, // 5.3) Evitar cierres accidentales al tocar fuera.
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 5.4) Mostrar el código leído.
                Text(
                  'El código: $numeros',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 12),
                // 5.5) Campo nombre (texto normal).
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(
                    labelText: 'Escribe el nombre del producto',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                // 5.6) Campo precio (numérico). Quitar obscureText: no es contraseña.
                TextField(
                  controller: precio,
                  decoration: const InputDecoration(
                    labelText: 'Escribe el precio',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),
          actions: [
            // 5.7) Guardar: validar mínimo y luego insertar.
            TextButton(
              onPressed: () async {
                final codigo = numeros.trim();
                final nom = nombre.text.trim();
                final pre = precio.text.trim();

                // 5.7.1) Validaciones básicas para UX clara.
                if (nom.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('El nombre no puede estar vacío'),
                    ),
                  );
                  return;
                }
                if (pre.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('El precio no puede estar vacío'),
                    ),
                  );
                  return;
                }
                // 5.7.2) Validar que el precio sea número válido (decimal).
                final precioNum = double.tryParse(pre);
                if (precioNum == null || precioNum <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ingresa un precio válido mayor a 0'),
                    ),
                  );
                  return;
                }

                try {
                  // 5.7.3) Insertar en BD; guardar precio como texto (consistente con tu esquema actual).
                  await Basedatoshelper().insertar(codigo, nom, pre);

                  // 5.7.4) Feedback de éxito opcional.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Producto guardado')),
                  );

                  // 5.7.5) Cerrar el diálogo tras guardar.
                  Navigator.pop(context);
                } catch (e) {
                  // 5.7.6) Manejo de error en inserción.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al guardar: $e')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
            // 5.8) Cancelar: cerrar sin acciones.
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    // 5.9) Al cerrar el diálogo (éxito o cancelación), permitir otro escaneo.
    setState(() {
      ventana = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 6) Estructura principal de la pantalla.
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR con SQFlite'),
        backgroundColor: const Color.fromARGB(255, 5, 255, 17),
      ),
      // 7) Lector de QR: 'onDetect' puede dispararse muchas veces por segundo.
      body: MobileScanner(
        onDetect: (capture) {
          // 7.1) Evitar múltiples diálogos simultáneos.
          if (ventana) return;

          // 7.2) Tomar el primer código detectado.
          final barcode = capture.barcodes.first;
          final numeros = barcode.rawValue ?? 'Sin codigo';

          // 7.3) Si hay código válido, abrir diálogo y bloquear nueva ventana.
          if (numeros != 'Sin codigo' && numeros.trim().isNotEmpty) {
            setState(() {
              ventana = true;
            });
            _mostrarDatos(numeros);
          }
        },
      ),
    );
  }
}
