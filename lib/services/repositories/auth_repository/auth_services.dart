import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:main/model/user_model/user_model.dart';
import 'package:main/services/repositories/auth_repository/auth_token_manager.dart';

class AuthService {
  final FirebaseAuth _auth;

  final FirebaseFirestore _firestore;
  final TokenManager _tokenManager;

  AuthService({
    FirebaseAuth? auth,

    FirebaseFirestore? firestore,
    TokenManager? tokenManager,
  }) : _auth = auth ?? FirebaseAuth.instance,

       _firestore = firestore ?? FirebaseFirestore.instance,
       _tokenManager = tokenManager ?? TokenManager();

  User? get currentUser => _auth.currentUser;

  bool isEmail(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(input);
  }

  bool isPhone(String input) {
    final phoneRegex = RegExp(r'^(\+63|0)?9\d{9}$'); // PH mobile format
    return phoneRegex.hasMatch(input);
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print('User registered successfully: ${userCredential.user?.email}');

      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'email': userCredential.user!.email,
              'uid': userCredential.user!.uid,
              'createdAt': FieldValue.serverTimestamp(),
            });

        print('User details saved to Firestore');
      }

      return;
    } on FirebaseAuthException catch (e) {
      // Handle errors (e.g., weak password, invalid email format)
      print('Error during registration: ${e.message}');
      throw Exception(_firebaseAuthErrorMessage(e));
    } catch (e) {
      // Handle any other errors
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred during registration');
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await _tokenManager.getToken();
      print('Token: $token');
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseAuthErrorMessage(e));
    }
  }

  Future<void> updateUserFcmToken(String userId) async {
    final msgS = FirebaseMessaging.instance;
    final token = await msgS.getToken();
    print("FCM TOKEN: $token");

    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'token': token,
      });
    }
  }

  Future<String?> getUserFcmToken(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    if (doc.exists && doc.data()!.containsKey('token')) {
      return doc['token'];
    }
    return null;
  }

  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    String? verificationId;
    int? resendToken;

    print('[DEBUG] Sending OTP to: $phoneNumber');

    final Completer<void> completer = Completer();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('[DEBUG] verificationCompleted');
          // Optional auto-sign in:
          // await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('[DEBUG] verificationFailed: ${e.message}');
          if (!completer.isCompleted) completer.complete();
          throw Exception(_firebaseAuthErrorMessage(e));
        },
        codeSent: (String verificationIdReceived, int? resendTokenReceived) {
          print('[DEBUG] codeSent');
          verificationId = verificationIdReceived;
          resendToken = resendTokenReceived;
          if (!completer.isCompleted) completer.complete();
        },
        codeAutoRetrievalTimeout: (String verificationIdReceived) {
          print('[DEBUG] autoRetrievalTimeout');
          verificationId = verificationIdReceived;
          if (!completer.isCompleted) completer.complete();
        },
      );

      await completer.future;

      if (verificationId == null) {
        throw Exception('Verification ID was not received.');
      }

      return {
        'phoneNumber': phoneNumber,
        'verificationId': verificationId,
        'resendToken': resendToken,
      };
    } catch (e) {
      throw Exception('OTP sending failed. Please try again.');
    }
  }

  Future<void> verifyOtpCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        throw Exception('User authentication failed.');
      }

      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        await userDocRef.set({
          'uid': user.uid,
          'phoneNumber': user.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      throw Exception(_firebaseAuthErrorMessage(e));
    } catch (e) {
      // Handle all other errors
      throw Exception('OTP verification failed. Please try again.');
    }
  }

  String _firebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'session-expired':
        return 'The verification session has expired. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'invalid-phone-number':
        return 'The phone number is invalid. Please check and try again.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email or phone number.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already in use. Please try another email or login.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but a different sign-in method.';
      default:
        return 'Authentication failed. (${e.message})';
    }
  }

  Future<UserModel> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      print('User doc exists: ${doc.exists}');
      print('User doc data: ${doc.data()}');

      if (!doc.exists) throw Exception('User not found');
      final data = doc.data();
      if (data == null) throw Exception('User data is null');

      final user = UserModel.fromJson({...data, 'uid': doc.id});
      print('User model parsed: $user');
      return user;
    } catch (e) {
      print('Error in getUserById: $e');
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsers(String currentUserId) async {
    try {
      final querySnapshot = await _firestore.collection('users').get();

      final allUsers = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson({...data, 'uid': doc.id});
      }).toList();

      // Step 1: Fetch all chats where current user is involved
      final chatSnapshot = await _firestore
          .collection('chats')
          .where('userIdArr', arrayContains: currentUserId)
          .get();

      // Step 2: Extract all user IDs from chats
      final chattedUserIds = <String>{};
      for (final doc in chatSnapshot.docs) {
        final userIdArr = List<String>.from(doc['userIdArr']);
        for (final id in userIdArr) {
          if (id != currentUserId) chattedUserIds.add(id);
        }
      }

      // Step 3: Filter out users already chatted with
      final filtered = allUsers
          .where(
            (user) =>
                user.uid != currentUserId && !chattedUserIds.contains(user.uid),
          )
          .toList();

      return filtered;
    } catch (e) {
      print('Error fetching all users: $e');
      throw Exception('Failed to fetch users');
    }
  }
}
