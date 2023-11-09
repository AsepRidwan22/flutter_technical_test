import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_technical_test/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceApiAccount {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<String> emailSignIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Check if the user is verified
    final isVerified = userCredential.user!.emailVerified;

    if (isVerified) {
      final userFirestore =
          firebaseStore.collection('users').doc(userCredential.user!.uid);
      await userFirestore.update({
        'isVerification': true,
      });
      return "Sign In Email Success";
    } else if (!isVerified) {
      throw FirebaseException(
        message: 'Your account must be verified email before you can sign in',
        plugin: 'error_verified',
      );
    } else {
      return "Sign In Email Failed";
      // throw FirebaseException(
      //   message: 'Sign In Failed',
      //   plugin: 'error_general',
      // );
    }
  }

  Future<List<UsersModel>> getListUsers() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final usersCollection = firebaseStore.collection('users');
        final querySnapshot = await usersCollection.get();

        final userList = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return UsersModel(
              email: data['email'], isVerification: data['isVerification']);
        }).toList();

        return userList;
      } else {
        throw FirebaseAuthException(
          code: 'user_not_logged_in',
          message: 'User is not logged in.',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return user;
  }

  Future<String> emailSignUp(String name, String email, String password) async {
    // Sign up the user
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Create a document in the `/users` collection
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid);
    await userDoc.set({
      'name': name,
      'email': email,
      'isVerification': false,
    }).catchError((e) {
      debugPrint('Error while adding data to Firestore: $e');
    });

    // Check if the user's email is verified
    if (!userCredential.user!.emailVerified) {
      // Send email verification
      userCredential.user!.sendEmailVerification();

      // Log out the user to force them to verify their email
      await emailSignOut();

      return "Please verify your email before using the app.";
    }

    return "Sign Up Email Success";
  }

  Future<String> forgotPassword(String email) async {
    final response = await firebaseAuth
        .sendPasswordResetEmail(
          email: email,
        )
        .then((value) => true)
        .onError((error, stackTrace) => false);

    if (response) {
      // return "Password reset request successful. Please check your email.";
      throw FirebaseException(
        message: "Password reset request successful. Please check your email.",
        plugin: 'error_verified',
      );
    } else {
      return "Failed to submit password reset request.";
    }
  }

  Future<String> emailSignOut() async {
    final respons = await firebaseAuth
        .signOut()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    final userCheck = firebaseAuth.currentUser;

    if (respons) {
      if (userCheck == null) {
        return "Sign Out Email Success";
      } else {
        throw FirebaseException(plugin: "User is not Recognized");
      }
    } else {
      throw FirebaseException(plugin: "Failed Email Sign Out");
    }
  }
}
