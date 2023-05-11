import 'package:flutter/material.dart';

import '../app_services.dart';
import '../widget/buttons.dart';
import 'services/navigation_service/navigation_service/test_navigation_service.dart';

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            InkWellButton(
              child: const Text('Clock'),
              onTap: () =>
                  AppServices.navigationService.navigate(ClockTestPagePath()),
            ),
          ],
        ),
      ),
    );
  }
}
