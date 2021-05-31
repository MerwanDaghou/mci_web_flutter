
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

// ignore: camel_case_types
class ProRegister_Model{
    static ProRegister_Model _crModel;
    String _proType, _country, _city, _postalCode, _address, _phoneNumber, _namePro, _mail, _pwd, _login;
    DateTime _birthdateUser;
    String _sErrorMessage;
    FirebaseAuth fAuth;
    FirebaseFirestore fStore;

    ProRegister_Model(){
      fAuth = FirebaseAuth.instance;
      fStore = FirebaseFirestore.instance;
    }

    //Pattern Singleton
    static ProRegister_Model getInstance(){
      if(_crModel==null){
        _crModel = new ProRegister_Model();
      }
       return _crModel;
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


    void setTypeOfPro(String _newProType){
      _proType = _newProType;
    }

    void setLocationData(String _newCountry, String _newCity, String _newPostalCode, String _newAddress){
      _country = _newCountry;
      _city    = _newCity;
      _postalCode = _newPostalCode;
      _address    = _newAddress;
    }

    void setContactInformation(String _newNamePro, String _newPhoneNumber){
      _namePro = _newNamePro;
      _phoneNumber = _newPhoneNumber;
    }

    void setLoginInformation(String _newLogin, String _newMail, String _newPwd){
      _login = _newLogin;
      _mail = _newMail;
      _pwd  = _newPwd;
    }

    // Check if Login is available : true if is ok
    Future<bool> checkLoginAvailable() async {
      bool bAvailable;
      QuerySnapshot querySnapshot;
      int i=0;

      try {
        final data = await fStore.collection("users").where(
            "login", isEqualTo:_login).get();
        log("login : " +_login);
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

      try{
        UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(email: _mail, password: _pwd);
        if(userCredential.user.uid != null){
            DocumentReference documentReference = fStore.collection("users").doc(userCredential.user.uid);
            try {
              await documentReference.set({
                "phone_number": _phoneNumber,
                "country": _country,
                "city": _city,
                "address": _address,
                "name_pro": _namePro,
                "login": _login,
                "type_of_pro": _proType,
                "is_pro": true,
                "about" : "Horaires, adresse, numéro de téléphone",
                "description" : "Décrivez l'ambiance de votre club pour attirer les clients !"
              });
              bReturn = true;
            }catch (e){
              setErrorMessage(3);
              bReturn= false;
          }
        }
      }on FirebaseAuthException catch (e){
        if (e.code == 'weak-password') {
          bReturn = false;
          setErrorMessage(2);
        } else if (e.code == 'email-already-in-use') {
          bReturn = false;
          setErrorMessage(1);
        }
      }catch (e){
        bReturn = false;
        setErrorMessage(3);
      }

      log(bReturn.toString());
      return bReturn;
    }

}