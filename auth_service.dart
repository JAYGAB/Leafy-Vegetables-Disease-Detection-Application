// lib/auth_service.dart
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Timer? _logoutTimer;

  void startLogoutTimer() {
    _logoutTimer?.cancel(); 
    _logoutTimer = Timer(Duration(minutes: 10), () {
      FirebaseAuth.instance.signOut(); 
    });
  }

  void resetLogoutTimer() {
    startLogoutTimer(); 
  }

  void dispose() {
    _logoutTimer?.cancel(); 
  }
}
