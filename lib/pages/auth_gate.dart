import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'home_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? hostel;
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    // Already logged in → home
    if (auth.user != null) return const HomePage();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Choose Hostel'),
                items: const [
                  DropdownMenuItem(value: 'A‑Block', child: Text('A‑Block')),
                  DropdownMenuItem(value: 'B‑Block', child: Text('B‑Block')),
                  DropdownMenuItem(value: 'C‑Block', child: Text('C‑Block')),
                ],
                onChanged: (v) => setState(() => hostel = v),
              ),
              const SizedBox(height: 24),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              FilledButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login with Google'),
                onPressed: hostel == null
                    ? null
                    : () async {
                        try {
                          await auth.signInWithGoogle(hostel!);
                        } catch (e) {
                          setState(() => error = e.toString());
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
