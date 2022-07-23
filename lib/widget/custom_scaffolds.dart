import 'package:flutter/material.dart';

class GradientScaffold extends Scaffold {
  GradientScaffold({Key? key, required Widget body})
      : super(
          key: key,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(42, 0, 255, 0),
                      Color.fromRGBO(42, 0, 255, 0.19),
                    ],
                    stops: [0.6, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              body,
            ],
          ),
        );
}
