import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/data/data.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({super.key, this.theWidth, this.theHeight, this.theChild});

  final theWidth;
  final theHeight;
  final theChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: dourado.withOpacity(0.9),
        child: Stack(
          children: [
            // blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(),
            ),
            // gradient effect
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.13),
                  ),
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ])),
            ),
            // child
            Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: theChild,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
