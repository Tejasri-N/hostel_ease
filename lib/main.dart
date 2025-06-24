import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'pages/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HostelEaseApp());
}

class HostelEaseApp extends StatelessWidget {
  const HostelEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hostel Ease',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
          ),
          cardTheme: const CardThemeData(color: Colors.brown),
        ),
        home: const AuthGate(),
      ),
    );
  }
}
