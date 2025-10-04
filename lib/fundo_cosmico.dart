import 'package:flutter/material.dart';
import 'dart:math';

class FundoCosmico extends StatelessWidget {
  final Widget child;
  const FundoCosmico({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = Random();

    final estrelas = List.generate(100, (index) {
      final left = random.nextDouble() * size.width;
      final top = random.nextDouble() * size.height;
      return Positioned(
        top: top,
        left: left,
        child: Container(
          height: 2,
          width: 2,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );
    });

    return Stack(
      children: [
        // Fundo gradiente cósmico
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D1B2A), Colors.black],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        // Estrelas posicionadas aleatoriamente
        ...estrelas,
        // Conteúdo principal
        SafeArea(child: child),
      ],
    );
  }
}
