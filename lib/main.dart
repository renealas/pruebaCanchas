import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Paginas
import './pages/home.dart';

// Providers
import './providers/reservas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Reservas(),
        ),
      ],
      child: MaterialApp(
        title: 'Canchas Reserva',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
