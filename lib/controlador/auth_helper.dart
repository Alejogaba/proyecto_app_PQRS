import 'dart:developer';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';





class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail(
      {String email ='', String password='', bool estaCreado = false}) async {
    try {
      var res = null;
      if (estaCreado) {
        res = await signupWithEmail(
            email: email, password: password, estaRegistrado: estaCreado);
      } else {
        res = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      final User user = res.user;
     
      print('Ingreso Exitoso');
      Future.delayed(
        Duration(seconds: 4),
        () {},
      );
      return user;
    } on FirebaseAuthException catch (e) {
      var user = null;
        FirebaseFirestore _db = FirebaseFirestore.instance;
        var existe =
            await _db.collection("users").doc(email.toLowerCase()).get();
      log('Error: ' + e.message! + ' - Codigo: ' + e.code);
      if (e.code == 'user-not-found'&&existe.exists) {
        log(existe.exists.toString());
        user = await signupWithEmail(email: email, password: password, estaRegistrado: true);
      if (user != null) {
                                        log(user);
                                        
                                      }
      }else{
        
      
      }
       
    } catch (e) {
      log(e.toString());
    }
  }

  static signupWithEmail(
      {String email='',
      String password='',
      String rol = 'user',
      bool estaRegistrado = false,
      }) async {
    try {
      FirebaseFirestore _db = FirebaseFirestore.instance;

    var existe = await _db.collection("users").doc(email).get();
    if (existe.exists==false&&estaRegistrado==false) {
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
    }  on FirebaseAuthException catch (e) {
     
    
    } catch (e) {
     log(e.toString());
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


