import 'package:events_app/providers/event_provider.dart';
import 'package:events_app/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: "Inter"),
        bodySmall: TextStyle(fontFamily: "Inter"),
        bodyLarge: TextStyle(fontFamily: "Inter"),
      )),
      debugShowCheckedModeBanner: false,
      title: 'Events App',
      home: const EventScreen(),
    );
  }
}
