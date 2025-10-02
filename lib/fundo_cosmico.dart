import 'package:flutter/material.dart';
import 'dart:math';

class FundoCosmico extends StatelessWidget {
  final Widget child;
  const FundoCosmico({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final estrelas = List.generate(100, (index) {
      final random = Random();
      final left = random.nextDouble() * MediaQuery.of(context).size.width;
      final top = random.nextDouble() * MediaQuery.of(context).size.height;
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
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D1B2A), Colors.black],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        ...estrelas,
        child,
      ],
    );
  }
}
