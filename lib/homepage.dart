import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> estrelas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      gerarEstrelas(screenWidth);
    });
  }

  void gerarEstrelas(double screenWidth) {
    estrelas.clear(); // evita acúmulo em hot reload
    final random = Random();
    estrelas.addAll(List.generate(100, (i) {
      final left = random.nextDouble() * screenWidth;
      final delay = random.nextInt(5000);
      return _estrelaAnimada(left, delay);
    }));
    setState(() {});
  }

  Widget _estrelaAnimada(double left, int delay) {
    return Positioned(
      bottom: 0,
      left: left,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 5000 + delay),
        curve: Curves.easeOut,
        height: 2,
        width: 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(title: const Text('Menu Principal')),
      body: Stack(
        children: [
          // Fundo cósmico
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1B2A), Colors.black],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Estrelas animadas
          ...estrelas,
          // Conteúdo principal
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bem-vindo à sua organização de compras 🛒',
                    style: textStyle?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit_document),
                    label: const Text('Preparar Lista'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/preparar');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Lista em compra'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/comprando');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.auto_stories),
                    label: const Text('Listas Anteriores'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/historico');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/meu_logotipo.png',
                    height: 100,
                    fit: BoxFit.contain,
                    semanticLabel: 'Logotipo do aplicativo',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
