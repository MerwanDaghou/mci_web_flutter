import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

class UserRegister_Model{
  String _country, _city, _postalCode, _lastNameUser, _firstNameUser, _mail, _pwd, _login;
  DateTime _birthdate;
  String _sErrorMessage;
  FirebaseAuth fAuth;
  FirebaseFirestore fStore;


  UserRegister_Model(){
    fAuth = FirebaseAuth.instance;
    fStore = FirebaseFirestore.instance;
  }


  String getErrorMessage(){
    return _sErrorMessage;
  }

  //setters
  void setErrorMessage(int iCodeError){
    switch(iCodeError){
    //Mail is already used
      case 1 :
        _sErrorMessage = "L'e-mail est déjà utilisé !";
        break;
      case 2:
        _sErrorMessage = "Le mot de passe est trop faible.";
        break;
      case 3:
        _sErrorMessage = "Erreur de connexion !";
        break;
      case 4:
        _sErrorMessage = "Le login n'est pas disponible !";
        break;
    }
  }

  void setLocationData(String _newCountry, String _newCity, String _newPostalCode){
    _country = _newCountry;
    _city    = _newCity;
    _postalCode = _newPostalCode;
  }

  void setNameUserToModel(String _newFirstName, String _newLastName){
    _firstNameUser = _newFirstName;
    _lastNameUser = _newLastName;
  }

  void setLoginInformation(String _newLogin, String _newMail, String _newPwd){
    _login = _newLogin;
    _mail = _newMail;
    _pwd  = _newPwd;
  }

  void setBirthdate(DateTime _newBirthdate){
    _birthdate = _newBirthdate;
  }

  // Check if Login is available : true if is ok
  Future<bool> checkLoginAvailable() async {
    bool bAvailable;
    QuerySnapshot querySnapshot;
    int i=0;

    try {
      final data = await fStore.collection("users").where(
          "login", isEqualTo:_login).get();
      // log("login : " +_login);
      querySnapshot = data;
      log(querySnapshot.docs.toString());
      if(querySnapshot.docs.isEmpty){
        bAvailable = true;
      }
      else{
        bAvailable = false;
        setErrorMessage(4);
      }
      //   querySnapshot.docs.forEach((doc) {
      //     i++;
      //   });
      //
      //   if(i>0){
      //     bAvailable = false;
      //     setErrorMessage(4);
      //   }
      //   else {
      //     bAvailable = true;
      //   }
    }
    on FirebaseException  catch (e) {
      setErrorMessage(3);
      bAvailable = false;
    }

    return bAvailable;
  }

  //Register
  Future<bool> register() async{
    bool bReturn;

    log("mail : " + _mail + " pwd : " + _pwd);

    try{
      UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(email: _mail, password: _pwd);
      log("uid : " + userCredential.user.uid);
      if(userCredential.user.uid != null){
        DocumentReference documentReference = fStore.collection("users").doc(userCredential.user.uid);
        try {
          await documentReference.set({
            "first_name": _firstNameUser,
            "last_name" : _lastNameUser,
            "birthdate" : _birthdate,
            "country": _country,
            "city": _city,
            "login": _login,
            "is_pro": false,
          });
          bReturn = true;
        }catch (e){
          setErrorMessage(3);
          bReturn= false;
        }
      }
    }on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        log("erreur 2");
        bReturn = false;
        setErrorMessage(2);
      } else if (e.code == 'email-already-in-use') {
        log("erreur 1");
        bReturn = false;
        setErrorMessage(1);
      }
    }catch (e){
      log("erreur 3");
      bReturn = false;
      setErrorMessage(3);
    }

    log(bReturn.toString());
    return bReturn;
  }
}