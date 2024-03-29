import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function for email/password sign-in
  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'success': true,
        'message': 'success',
        'user': userCredential.user
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {'success': false, 'message': 'Account does not exist'};
      } else if (e.code == 'wrong-password') {
        return {'success': false, 'message': 'Invalid login credentials'};
      } else {
        return {'success': false, 'message': 'Sorry, an error occurred'};
      }
    } catch (e) {
      // Catch any unexpected errors
      return {'success': false, 'message': 'An unknown error occurred'};
    }
  }

  // Function for email/password sign-up
  Future<Map<String, dynamic>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'success': true,
        'message': 'success',
        'user': userCredential.user
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {'success': false, 'message': 'Password too weak'};
      } else if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'message': 'Account with this email already exists'
        };
      } else {
        return {'success': false, 'message': 'Sorry, an error occurred'};
      }
    } catch (e) {
      // Catch any unexpected errors
      return {'success': false, 'message': 'An unknown error occurred'};
    }
  }

  // Function to check if the user is logged in
  Future<bool> isLoggedIn() async {
    // Simply check if FirebaseAuth's current user is logged in
    return _auth.currentUser != null;
  }

  // Function to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
