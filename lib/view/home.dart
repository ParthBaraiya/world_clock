import 'package:flutter/material.dart';
import '../clock/clock.dart';
import '../theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.i.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: const Center(
        child: Clock(
          radius: 300,
        ),
      ),
    );
  }
}
