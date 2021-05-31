import 'UserRegister_Model.dart';

class UserRegister_Controller{
  String _sErrorMessage;
  UserRegister_Model _reModel;

  UserRegister_Controller(){
    _reModel = new UserRegister_Model();
  }

  void setErrorMessage(int iCodeErreur){
    switch(iCodeErreur){
    // if age is under 16
      case 1 :
        _sErrorMessage = "Vous devez avoir plus de 15 ans pour utiliser l'application !";
        break;
      case 2 :
        _sErrorMessage = "Le nom et le prénom sont vides.";
        break;
    // Mail format is incorrect
      case 3 :
        _sErrorMessage = "L'adresse mail est incorrect (ex : john@mail.fr)";
        break;
      case 4 :
        _sErrorMessage= "Le mot de passe doit faire minimum 8 caractères, doit contenir au moins 1 majuscule et 1 chiffre";
        break;
    // if login length is under 4
      case 5 :
        _sErrorMessage = "Le login doit faire au moins 4 caractères, sans espaces ni majuscules.";
        break;
      case 6 :
        _sErrorMessage = "Des champs sont vides ou pas correctement remplis";

    }
  }

  String getErrorMessage(){
    return _sErrorMessage;
  }

  void setBirthdate(DateTime dBirthdate){
    _reModel.setBirthdate(dBirthdate);
  }

  // check if age is over 16 years old
  bool checkAge(DateTime birthdate) {
    // Current time - at this moment
    DateTime today = DateTime.now();

    // Date to check but moved 16 years ahead
    DateTime adultDate = DateTime(
      birthdate.year + 16,
      birthdate.month,
      birthdate.day,
    );

    bool bReturn = adultDate.isBefore(today) ;
    if(!bReturn){
      setErrorMessage(1);
    }
    return bReturn;
  }

  //Check if name club length is over 2
  bool checkLengthField(String _sFirstName, String sLastName){
    bool bReturn;
    if(_sFirstName.isEmpty || sLastName.isEmpty){
      bReturn = false;
      setErrorMessage(2);
    }
    else{
      bReturn = true;
    }

    return bReturn;
  }

  //set DATA to model
  void setNameUserToModel(String _sFirstName, String _sLastName){
    _reModel.setNameUserToModel(_sFirstName, _sLastName);
  }

  String getFirebaseErrorMessage(){
    return _reModel.getErrorMessage();
  }

  //set DATA to model
  void setLoginInformationToModel(String _sLogin,String _sMail, String sPwd){
    _reModel.setLoginInformation(_sLogin, _sMail, sPwd);
  }

  //check if mail format is correct
  bool checkMailFormat(String sMail){
    bool bReturn;
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(sMail)){
      bReturn = true;
    }
    else{
      setErrorMessage(3);
      bReturn = false;
    }
    return bReturn;
  }

  //check pwd format (1 upper case, 1 lower case, 1 number, length > 8
  bool isPasswordCompliant(String password, [int minLength = 8]) {
    bool bReturn;

    if (password == null || password.isEmpty) {
      bReturn = false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    // bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    if(hasDigits & hasUppercase & hasLowercase & hasMinLength){
      bReturn = true;
    }
    else{
      bReturn = false;
      setErrorMessage(4);
    }
    return bReturn;
  }

  //Check login format (just lower case and digits)
  bool checkLoginFormat(String sLogin,[int minLength=3]){
    bool bReturn;

    if (sLogin == null || sLogin.isEmpty) {
      bReturn = false;
    }

    bool hasUppercase = sLogin.contains(new RegExp(r'[A-Z]'));
    // bool hasDigits = sLogin.contains(new RegExp(r'[0-9]'));
    // bool hasLowercase = sLogin.contains(new RegExp(r'[a-z]'));
    // bool hasSpecialCharacters = sLogin.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = sLogin.length > minLength;
    bool hasSpace     = sLogin.contains(" ");

    if(hasUppercase || hasSpace || !hasMinLength){

      bReturn = false;
      setErrorMessage(5);
    }
    else{
      bReturn = true;
    }
    return bReturn;
  }

  Future<bool> checkLoginIsAvailable() {
    return _reModel.checkLoginAvailable();
  }

  Future<bool> register(){
    return _reModel.register();
  }

  void setLocationToModel(String _newCountry, String _newCity, String _newPostalCode){
    _reModel.setLocationData(_newCountry, _newCity, _newPostalCode);
  }

  //check data format
  bool verifyDATA(String _newCountry, String _newCity, String _newPostalCode){
    if(_newCountry.replaceAll("\\s+", "").isEmpty || _newCity.replaceAll("\\s+", "").length < 3 || _newPostalCode.replaceAll("\\s+", "").length != 5){
      setErrorMessage(6);
      return false;
    }

    return true;
  }

}