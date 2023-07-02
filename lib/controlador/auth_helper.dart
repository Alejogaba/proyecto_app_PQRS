import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snackbar/snackbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Correo de restablecimiento enviado correctamente',
          'Siga las instruciones en su correo',
          duration: Duration(seconds: 5),
          margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Color.fromARGB(211, 28, 138, 46),
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          colorText: Color.fromARGB(255, 228, 219, 218));
    } catch (e) {
      Get.snackbar('Error',
          'Ocurrio un error, verifique que el correo este correctamente escrito',
          duration: Duration(seconds: 5),
          margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Color.fromARGB(213, 211, 31, 31),
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          colorText: Color.fromARGB(255, 228, 219, 218));
      log('Error resetear la contraseña: $e');
    }
  }

  static signInWithEmail(BuildContext context,
      {String email = '', String password = ''}) async {
    try {
      var res;
      res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = await res.user;
      print('Ingreso Exitoso');
      Future.delayed(
        Duration(seconds: 4),
        () {},
      );
      return user;
    } on FirebaseAuthException catch (e) {
      log('Error: ' + e.message! + ' - Codigo: ' + e.code);
      var mensaje = getErrorMessageFromFirebaseAuthException(e);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: mensaje.toString(),
        ),
      );
    } catch (e) {
      log('Error en login: ' + e.toString());
    }
  }

  static signupWithEmail({
    String email = '',
    String password = '',
    String rol = 'user',
    bool estaRegistrado = false,
  }) async {
    try {
      FirebaseFirestore _db = FirebaseFirestore.instance;

      var existe = await _db.collection("users").doc(email).get();
      if (existe.exists == false && estaRegistrado == false) {
        Map<String, dynamic> userData = {
          "FuncionarioImage": "",
          "fechanacimiento": "",
          "area": "",
          "telefono": "",
          "cargo": "",
          "password": "",
          "identificacion": "",
          "nombre": "",
          "name": "",
          "email": email.toLowerCase(),
          "last_login": "",
          "created_at": "",
          "role": rol,
          "build_number": "",
        };
        await _db.collection("users").doc(email).set(userData);
      }
      final UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (res.user != null) {
        if (!estaRegistrado) {
          UserHelper.saveUser(res.user!, rol: rol);
        }
      }
      Future.delayed(
        Duration(seconds: 2),
        () {},
      );
      return res.user;
    } on FirebaseAuthException {
    } catch (e) {
      log(e.toString());
    }
  }

  static estaLogeado() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  static handleSignOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static var _dbRT = FirebaseDatabase.instance.reference();

  Future<void> eliminarFuncionario(String email) async {
    CollectionReference funcionarios =
        FirebaseFirestore.instance.collection('users');

    return funcionarios
        .doc(email)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static saveUser(User user, {String rol = 'user'}) async {
    Map<String, dynamic> userData = {
      "FuncionarioImage": "",
      "fechanacimiento": "",
      "area": "",
      "telefono": "",
      "cargo": "",
      "password": "",
      "identificacion": "",
      "nombre": user.displayName,
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime!.millisecondsSinceEpoch,
      "role": rol,
    };
    final userRef = _db.collection("users").doc(user.email);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      });
    } else {
      await _db.collection("users").doc(user.email).set(userData);
    }
  }

  static saveUserAdmin(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime!.millisecondsSinceEpoch,
      "role": "admin",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
  }
}

String extractErrorCodeFromErrorMessage(String errorMessage) {
  RegExp regExp = RegExp(r'\((.*?)\)');
  Match? match = regExp.firstMatch(errorMessage);
  String errorCode = match?.group(1) ?? 'unknown';
  return errorCode;
}

String getErrorMessageFromFirebaseAuthException(FirebaseAuthException exception) {
  String errorMessage = exception.message ?? 'An unknown error occurred';
  String errorCode = extractErrorCodeFromErrorMessage(errorMessage);
  
  String customErrorMessage = '';

  switch (errorCode) {
    case 'auth/invalid-email':
      customErrorMessage = 'El correo electrónico proporcionado no es válido.';
      break;
    case 'auth/user-not-found':
      customErrorMessage = 'No se encontró un usuario con el correo electrónico proporcionado.';
      break;
    case 'auth/wrong-password':
      customErrorMessage = 'La contraseña es incorrecta.';
      break;
    // Agrega más casos para otros códigos de error según tus necesidades
    default:
      customErrorMessage = 'Se produjo un error en la autenticación.';
      break;
  }

  return customErrorMessage;
}

