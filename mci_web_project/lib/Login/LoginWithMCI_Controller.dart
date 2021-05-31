
import 'LoginWithMCI_Model.dart';


class LoginWithMCI_Controller{
  LoginWithMCI_Model _loModel;

  LoginWithMCI_Controller(){
    _loModel = new LoginWithMCI_Model();
  }

  Future<List<bool>> signIn(String _sNewMail, String _sNewPassword){
    // ignore: unrelated_type_equality_checks
    return _loModel.signIn(_sNewMail, _sNewPassword);
  }


}