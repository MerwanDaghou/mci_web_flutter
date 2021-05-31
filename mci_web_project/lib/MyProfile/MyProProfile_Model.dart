import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mci_web_project/Common/Professional.dart';
import 'dart:developer';
import 'package:mci_web_project/Common/Product.dart';

class MyProProfile_Model{
  FirebaseAuth _fAuth;
  FirebaseFirestore _fStore;
  FirebaseStorage _fStorage;
  String _sIDUser, _sLogin, _sFirstName, _sLastName, _sDescription, _sProfession,_urlProfilePicture, _sPhoneNumber, _sCity;
  bool _isHere;
  List<Product> _listProduct = new List();



  MyProProfile_Model(){
    _fAuth = FirebaseAuth.instance;
    _fStore = FirebaseFirestore.instance;
    _fStorage = FirebaseStorage.instance;
    _sIDUser = _fAuth.currentUser.uid;
  }


  String getFirstName(){
    return _sFirstName;
  }

  String getLastName(){
    return _sLastName;
  }

  String getLogin(){
//        Log.d("GET LOGIN : " , "Controller");
    return _sLogin;
  }

  String getProfilePicture(){
    return _urlProfilePicture;
  }

  String getProfession(){
    return _sProfession;
  }

  bool getIsHere(){
    return _isHere;
  }

  String getCity(){
    return _sCity;
  }

  String getDescription(){
    return _sDescription;
  }

  String getPhoneNumber(){
    return _sPhoneNumber;
  }

  List<Product> getListProduct(){
    return _listProduct;
  }

  Future<bool> getDATAFromFirestore() async{
    log("début requête");
    bool bReturn;

    try{
      DocumentSnapshot docUser;
      docUser = await _fStore.collection("users").doc(_sIDUser).get();
      _sLogin = docUser.get("login");
      _sFirstName = docUser.get("first_name");
      _sLastName = docUser.get("last_name");
      _sDescription = docUser.get("description");
      _sProfession = docUser.get("profession");
      _isHere      = docUser.get("is_here");
      _sPhoneNumber = docUser.get("phone_number");
      _sCity        = docUser.get("city");

      bReturn = true;
    }
    on FirebaseException catch (e){
      log(e.toString());
      bReturn = false;
    }

    return bReturn;
  }

  Future<bool> downloadProfilePicture()  async {
    bool _bReturn;
    try{
      _urlProfilePicture = await _fStorage.ref().child("profile_picture/" + _sIDUser + ".jpg").getDownloadURL();

      _bReturn = true;
    }
    catch (e){
      _bReturn = false;
    }
    log("fin requête");
    return _bReturn;
  }

  Future<bool> getListProductFromFirebase() async{
    bool _bReturn = true;
    QuerySnapshot querySnapshot;
    String  _urlProfilePicture;

    try{
      querySnapshot = await _fStore.collection("product").where("id_pro",isEqualTo: _sIDUser).get();
      await Future.forEach(querySnapshot.docs, (documentSnapshot) async{
        try{
          _urlProfilePicture = await _fStorage.ref().child("product/" + documentSnapshot.get("type_product") + "/" + documentSnapshot.id + ".jpg").getDownloadURL();
        }
        catch (e){
          _urlProfilePicture = "";
          log(e.toString());
        }

        _listProduct.add(new Product(documentSnapshot.id, _sIDUser, documentSnapshot.get("name_product"), documentSnapshot.get("description"), documentSnapshot.get("cost"), _urlProfilePicture));
      });
    }
    catch(e){
      log(e.toString());
      _bReturn = false;
    }

    return _bReturn;
  }


}

