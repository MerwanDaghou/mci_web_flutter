

class Professional{
  String _sIDUser, _sLogin, _sFirstName, _sLastName, _sProfession,_urlProfilePicture;

  Professional(String _newIDUser, String _newLogin, String _newFirstName, String _newLastName, String _newProfession, String _newUrlProfilePicture){
    _sIDUser = _newIDUser;
    _sLogin = _newLogin;
    _sFirstName = _newFirstName;
    _sLastName = _newLastName;
    _sProfession = _newProfession;
    _urlProfilePicture = _newUrlProfilePicture;
  }

  //getters
  String getIDUser() {
    return _sIDUser;
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


}