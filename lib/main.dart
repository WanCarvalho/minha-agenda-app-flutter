import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';
import 'package:minha_agenda_app/widgets/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContatoProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}
