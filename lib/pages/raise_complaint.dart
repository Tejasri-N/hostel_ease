import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Screen to raise a new maintenance complaint.
///
/// * The student’s hostel is auto‑filled from their profile (saved at login).
/// * Complaint fields are validated before enabling **Submit**.
/// * On submit a new document is added to `complaints/` with status **pending**.
class RaiseComplaintPage extends StatefulWidget {
  const RaiseComplaintPage({super.key});

  @override
  State<RaiseComplaintPage> createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage> {
  String? _hostel; // auto‑loaded once
  String? _issueType; // Room / Pod
  final _roomCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHostel();
  }

  Future<void> _loadHostel() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      _hostel = (doc.data() ?? {})['hostel'] as String?;
      _loading = false;
    });
  }

  Future<void> _submit() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('complaints').add({
      'hostel': _hostel,
      'issueType': _issueType,
      'roomOrPodNo': _roomCtrl.text.trim(),
      'description': _descCtrl.text.trim(),
      'status': 'pending',
      'raisedBy': uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted!')),
      );
      Navigator.pop(context); // back to Home
    }
  }

  bool get _isFormValid =>
      _issueType != null &&
      _roomCtrl.text.trim().isNotEmpty &&
      _descCtrl.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Raise Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hostel is fixed; show read‑only field
              TextFormField(
                initialValue: _hostel ?? '',
                decoration: const InputDecoration(labelText: 'Hostel'),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _issueType,
                decoration: const InputDecoration(labelText: 'Issue Type'),
                items: const [
                  DropdownMenuItem(value: 'Room', child: Text('Room')),
                  DropdownMenuItem(value: 'Pod', child: Text('Pod')),
                ],
                onChanged: (v) => setState(() => _issueType = v),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _roomCtrl,
                decoration: const InputDecoration(labelText: 'Room / Pod No'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descCtrl,
                decoration:
                    const InputDecoration(labelText: 'Issue Description'),
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isFormValid ? _submit : null,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
