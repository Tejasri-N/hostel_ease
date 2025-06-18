import 'package:flutter/material.dart';
import 'package:hostel_management/pages/RaiseComplaint.dart';
import 'package:hostel_management/pages/MyComplaints.dart';
import 'package:hostel_management/pages/RoomSwap.dart';

void main() {
  runApp(const HostelEaseApp());
}

class HostelEaseApp extends StatelessWidget {
  const HostelEaseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Ease',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20), // Increased vertical padding for taller rectangles
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.brown,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/raise_complaint': (context) => const RaiseComplaintPage(),
        '/my_complaints': (context) => const MyComplaintsPage(),
        '/room_swap': (context) => const RoomSwapPage(),
      },
    );
  }
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mobile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text('Hostel Ease'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    // Navigate to account view
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/raise_complaint');
                              },
                              child: const Text('Raise Complaint'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/my_complaints');
                              },
                              child: const Text('My Complaints'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Room Swap Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/room_swap');
                        },
                        child: const Text('Room Swap Request'),
                      ),
                      const SizedBox(height: 40),
                      // Recent Complaints Card
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Recent Complaints', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        ListTile(title: Text('Room 101: Leaky faucet')),
                                        ListTile(title: Text('Room 205: Broken light')),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      DropdownButton<String>(
                                        hint: const Text('Filter by Hostel'),
                                        dropdownColor: Colors.brown,
                                        style: const TextStyle(color: Colors.white),
                                        iconEnabledColor: Colors.white,
                                        items: const [
                                          DropdownMenuItem(value: 'Hostel A', child: Text('Hostel A')),
                                          DropdownMenuItem(value: 'Hostel B', child: Text('Hostel B')),
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 120,
                                        child: TextField(
                                          style: const TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            hintText: 'Keyword',
                                            hintStyle: const TextStyle(color: Colors.white70),
                                            border: const OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white70),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Hostel Notices Card
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Hostel Notices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              ListTile(title: Text('Notice: Water maintenance on 20th June')),
                              ListTile(title: Text('Notice: Wi-Fi upgrade scheduled')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.brown,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.brown),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(title: Text('Option 1', style: TextStyle(color: Colors.white))),
              ListTile(title: Text('Option 2', style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}