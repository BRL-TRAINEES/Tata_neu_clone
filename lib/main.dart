import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart'; 
import 'screens/homescreen.dart';
void main() {
  runApp(const ProviderScope(child: MyApp())); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldNavigate = ref.watch(navigationProvider);


    if (shouldNavigate==true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network("https://th.bing.com/th/id/OIP.zPrKJRPaoZo6sJYrAsXhCQAAAA?rs=1&pid=ImgDetMain"),
      ),
    );
  }
}
