import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:seatly/core/injection.dart';
import 'package:seatly/ui/providers/settings_providers.dart';
import 'package:seatly/ui/screen/add_screens/add_classroom_name_screen.dart';
import 'package:seatly/ui/screen/detail_screens/classroom_details_screen.dart';
import 'package:seatly/ui/screen/home_screen.dart';
import 'package:seatly/ui/screen/settings_screens/settings_screen.dart';
import 'package:seatly/ui/screen/splash_screen.dart';

void main() {
  configureDependencies();
  runApp(
    const ProviderScope(
        child: MyApp()
    )
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final themeMode = ref.watch(themeProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return MaterialApp(
      title: 'Seatly',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('nl', ''),
        Locale('fr', ''),
        Locale('de', ''),
        Locale('es', '')
      ],
      theme: ThemeData(
        textTheme: TextTheme(displayMedium: TextStyle(fontSize: fontSize)),
        primarySwatch: Colors.purple,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ), bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      ),
      darkTheme: ThemeData(
        textTheme: TextTheme(displayMedium: TextStyle(fontSize: fontSize)),
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ), bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
      ),
      themeMode: themeMode,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        // '/classroomLayoutView': (context) => const ClassroomLayoutViewScreen(),
        '/classroomDetail': (context) {
          final route = ModalRoute.of(context)!.settings.arguments as String;
          return ClassroomDetailScreen(classroomId: route);
        },
        // '/studentDetail': (context) {
        //   final route = ModalRoute.of(context)!.settings.arguments as String;
        //   return StudentDetailScreen(studentId: route);
        // },
        '/addClassroomName': (context) => const AddClassroomNameScreen(),
        // '/addStudent': (context) => const AddStudentScreen()
      },
    );
  }
}