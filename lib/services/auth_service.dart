import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  Future<void> signInWithGoogle(String hostel) async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    if (!googleUser.email.endsWith('@iith.ac.in')) {
      throw Exception('Please use your @iith.ac.in email');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final userCred = await _auth.signInWithCredential(credential);
    await _saveProfile(userCred.user!, hostel);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    notifyListeners();
  }

  Future<void> _saveProfile(User user, String hostel) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': user.displayName,
      'email': user.email,
      'hostel': hostel,
      'photo': user.photoURL,
    }, SetOptions(merge: true));
  }
}
