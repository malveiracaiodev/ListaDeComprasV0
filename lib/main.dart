import 'package:flutter/material.dart';
import '../homepage.dart';
import './historicopage.dart';
import './listapreparadapage.dart';
import './listapage.dart';
import './fundo_cosmico.dart'; // novo fundo cósmico

void main() {
  runApp(const ListaComprasApp());
}

class ListaComprasApp extends StatelessWidget {
  const ListaComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras Cósmica',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1B2A),
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF1B263B),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0D1B2A),
        ),
      ),
      home: const FundoCosmico(child: HomePage()),
      routes: {
        '/preparar': (context) =>
            const FundoCosmico(child: ListaPreparadaPage()),
        '/comprando': (context) => const FundoCosmico(child: ListaPage()),
        '/historico': (context) => const FundoCosmico(child: HistoricoPage()),
      },
    );
  }
}
