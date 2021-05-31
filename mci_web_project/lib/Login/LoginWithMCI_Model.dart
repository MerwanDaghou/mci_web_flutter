
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'LoginWithMCI_Controller.dart';

class LoginWithMCI_Model{
  FirebaseAuth _fAuth;
  FirebaseFirestore _fStore;
  bool _bReturnSignIn;
  bool _bIsPro;
  String sErrorMessage;
  LoginWithMCI_Controller loController;


  LoginWithMCI_Model(){
    log("new login model");
    _initializeApp();
  }

  void _initializeApp() async{
    //initalize FirebaseAuth and Firestore
    Firebase.initializeApp();
    _fAuth = FirebaseAuth.instance;
    _fStore = FirebaseFirestore.instance;
  }

  //getters
  String getErrorMessage(){return sErrorMessage;}

  //Authentification
  Future<List<bool>> signIn(String _sMail, String _sPassword) async{

    try{
      await _fAuth.signInWithEmailAndPassword(email: _sMail, password: _sPassword);
      _bReturnSignIn = true;

    }
    on FirebaseAuthException catch (e){
      _bReturnSignIn = false;
    }
    catch (e){
      _bReturnSignIn = false;
    }

    log(_bReturnSignIn.toString());

    if(_bReturnSignIn) {
      DocumentSnapshot docUser;
      try {
        log(_fAuth.currentUser.uid.toString());
        final data = await _fStore.collection("users").doc(
            _fAuth.currentUser.uid).get();
        docUser = data;
        _bIsPro = docUser.get("is_pro");
        // loController.setIsClub(docUser.get("is_club"));
      }
      on FirebaseException catch (e) {
        _bReturnSignIn = false;
      }
      catch (e){
        _bReturnSignIn = false;
        log(e.toString());
      }
    }

    return [_bReturnSignIn,_bIsPro];
  }
}