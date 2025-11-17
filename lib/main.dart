import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'screens/todo_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<TodoProvider>().isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        useMaterial3: true,
        primaryColor: const Color(0xFF6C63FF),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF333333)),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050816),
        useMaterial3: true,
        primaryColor: const Color(0xFF6C63FF),
        cardColor: const Color(0xFF151B2B),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFE5E7EB)),
        ),
      ),

      home: const TodoScreen(),
    );
  }
}
