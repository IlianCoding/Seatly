import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/core/injection.dart';
import 'package:seatly/ui/screen/home_screen.dart';

void main() {
  configureDependencies();
  runApp(
    const ProviderScope(
        child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}