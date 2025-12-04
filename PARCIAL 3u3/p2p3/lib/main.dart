import 'package:flutter/material.dart';
import 'package:p2p3/widget/pagina2.dart';
import 'package:p2p3/widget/pagina3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Pagina2());
  }
}
