import 'package:flutter/material.dart';

class RaiseComplaintPage extends StatefulWidget {
  const RaiseComplaintPage({super.key});

  @override
  State<RaiseComplaintPage> createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage>{
  String? _selectedHostel;
  String? _selectedIssueType;

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
              title: const Text("Raise your complaint"),
              leading: IconButton(
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                    },
                  icon: const Icon(Icons.menu),
              ),
              actions: [
                IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.account_circle_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                  child: Card(
                    color: Colors.brown,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 15),
                          Text(
                            'Hostel Name',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          DropdownButton<String>(
                            hint: Text(_selectedHostel ?? 'Select Hostel'),
                            dropdownColor: Colors.brown,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white,
                            items: [
                              DropdownMenuItem(value: 'Hostel A', child: Text('Hostel A')),
                              DropdownMenuItem(value: 'Hostel B', child: Text('Hostel B')),
                              DropdownMenuItem(value: 'Hostel C', child: Text('Hostel C')),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedHostel = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Select Issue Type',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          DropdownButton<String>(
                            hint: Text(_selectedIssueType ?? 'Room or Pod'),
                            dropdownColor: Colors.brown,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white,
                            items: [
                              DropdownMenuItem(value: 'Room Issue', child: Text('Room Issue')),
                              DropdownMenuItem(value: 'Pod Issue', child: Text('Pod Issue')),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedIssueType = newValue;
                              });
                            }, // Placeholder, enable with state management
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Room No / Pod No',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter number...',
                              hintStyle: TextStyle(color: Colors.white70),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Issue Briefing',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Describe your issue...',
                              hintStyle: TextStyle(color: Colors.white70),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            maxLines: 4,
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),

                  ),
                  ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}