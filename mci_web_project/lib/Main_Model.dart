import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Common/Professional.dart';
import 'dart:developer';

class Main_Model {
  FirebaseAuth _fAuth;
  FirebaseFirestore _fStore;
  FirebaseStorage _fStorage;
  List<Professional> _listPro = new List();

  Main_Model(){
    _fAuth = FirebaseAuth.instance;
    _fStore = FirebaseFirestore.instance;
    _fStorage = FirebaseStorage.instance;
  }

  List<Professional> getListPro(){
    return _listPro;
  }

  // Ajouter deux paramètres isHere et Profession
  Future<bool> getListProFromFirebase(String profession) async{
    bool _bReturn;
    QuerySnapshot querySnapshot;
    DocumentSnapshot docSnap;
    String  _urlProfilePicture;

    _listPro = new List();

    try {
      _bReturn = true;
      log("query");
      // Requête affichant la liste des professionnels
      //Ajouter condition where affichant la profession,
      if(profession == ""){
        querySnapshot = await _fStore.collection("users").where("is_pro",isEqualTo: true).limit(12).get();
      }
      else{
        querySnapshot = await _fStore.collection("users").where("is_pro",isEqualTo: true).where("profession",isEqualTo: profession).limit(12).get();

      }
      //
      log("size query : " + querySnapshot.size.toString());
      await Future.forEach(querySnapshot.docs, (documentSnapshot) async{
        try{
          docSnap = await _fStore.collection("users").doc(documentSnapshot.id).get();
          try{
            _urlProfilePicture = await _fStorage.ref().child("profile_picture/" + documentSnapshot.id + ".jpg").getDownloadURL();

          }catch(e){
            log(e.toString());
            _urlProfilePicture = "";
          }
          log("url" + _urlProfilePicture.toString());
          _listPro.add(new Professional(documentSnapshot.id, docSnap.get("login"), docSnap.get("first_name"), docSnap.get("last_name"), documentSnapshot.get("profession"), _urlProfilePicture));
        }
        catch (e){
          log("erreur "+ e.toString());
          _bReturn = false;
        }
      });


      _bReturn = true;
    }
    catch (e){
      _bReturn = false;
    }

    return _bReturn;
  }
}

