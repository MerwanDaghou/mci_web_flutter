import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UserRegister_Controller.dart';
import 'dart:developer';
import 'package:mci_web_project/Resources/UnicornOutlineButton.dart';
import 'package:mci_web_project/MyProfile/MyProfile_View.dart';
import 'package:mci_web_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:country_code_picker/country_code_picker.dart';



class Register_View extends StatefulWidget {

  @override
  Register_State createState() => Register_State();

}


class Register_State extends State<Register_View>{
  Icon mVisiblePassword = Icon(FontAwesomeIcons.eyeSlash, color: Colors.blueAccent);
  bool bPasswordHidden = true;
  String sErrorMessage = "";
  double dCircleValue = 0;
  UserRegister_Controller _urController = new UserRegister_Controller();
  final pwdController = TextEditingController();
  final mailController = TextEditingController();
  DateTime _birthdate = DateTime.now() ;
  String sCountry = "France";
  final _cityController = new TextEditingController();
  final _postalCodeController = new TextEditingController();
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final loginController = new TextEditingController();
  final pwdControllerPro = TextEditingController();
  final mailControllerPro = TextEditingController();
  final _cityControllerPro = new TextEditingController();
  final _postalCodeControllerPro = new TextEditingController();
  final firstNameControllerPro = new TextEditingController();
  final lastNameControllerPro = new TextEditingController();
  final loginControllerPro = new TextEditingController();
  DateTime _birthdatePro = DateTime.now() ;

  List<String> _listTypeOfPro = ["artisan", "boucher", "traiteur","vestimentaire","boulanger"];
  int _nSelect = 0;

  double _onUser = 0;
  double _onPro = 0;



  void _setIconPassword(){
    log("entrée dans procedure");
    setState(() {
      if(bPasswordHidden){
        bPasswordHidden = false;
        log("Password hidden : " + bPasswordHidden.toString());
        mVisiblePassword = Icon(FontAwesomeIcons.eye, color: Colors.blueAccent);

      }else{
        log("entrée dans faux");
        bPasswordHidden = true;
        mVisiblePassword = Icon(FontAwesomeIcons.eyeSlash, color: Colors.blue);
      }
    });
  }

  void _registerUser() async{
    if(_urController.checkAge(_birthdate)){
      _urController.setBirthdate(_birthdate);
      setState(() {
        sErrorMessage = "";
      });
      if(_urController.verifyDATA(sCountry, _cityController.text, _postalCodeController.text)){
        _urController.setLocationToModel(sCountry, _cityController.text, _postalCodeController.text);

        setState(() {
          sErrorMessage = "";
        });

        if(_urController.checkLengthField(firstNameController.text,lastNameController.text)){
          _urController.setNameUserToModel(firstNameController.text, lastNameController.text);
          setState(() {
            sErrorMessage = "";
          });
          // if check are okay
          if(_urController.checkMailFormat(mailController.text) & _urController.checkLoginFormat(loginController.text) & _urController.isPasswordCompliant(pwdController.text)){
            //set data to model and try to register
            _urController.setLoginInformationToModel(loginController.text,mailController.text, pwdController.text);

            //if login is available, try register
            final bLoginIsAvailable = await _urController.checkLoginIsAvailable();
            if(bLoginIsAvailable){
              try{
                final bRegister = await _urController.register();
                //If register is ok
                if(bRegister){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return MyApp();
                  }));
                }
                else{
                  setState(() {
                    log("FirebaseErrorMessage 1");
                    sErrorMessage = _urController.getFirebaseErrorMessage();
                  });
                }
              }catch (e){
                setState(() {
                  log("FirebaseErrorMessage 2");
                  // sErrorMessage = liController.getFirebaseErrorMessage();
                });
              }
            }else {
              setState(() {
                log("FirebaseErrorMessage 3");
                sErrorMessage = _urController.getFirebaseErrorMessage();
              });
            }
          }
          else{
            log("Login is disable");
            setState(() {
              log("Error message : " + _urController.getErrorMessage());
              sErrorMessage = _urController.getErrorMessage();
            });
          }
        }
        else{
          setState(() {
            sErrorMessage = _urController.getErrorMessage();
          });
        }
      }
      else{
        setState(() {
          sErrorMessage = _urController.getErrorMessage();
        });
      }
    }else{
      setState(() {
        sErrorMessage = _urController.getErrorMessage();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    final topBar = MediaQuery.of(context).padding.top;
    double fontSize1 = 0.025 * height;
    double fontSize2 = 0.021 * height;

    return Scaffold(
        body:
        Container(
            child: Column(
                children: [
                  Container(
                    height: 0.1*height,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 20,
                            left: 50,
                            child:  Text(
                                "MCI",
                                style : TextStyle(
                                    fontSize: 32,
                                    color: Colors.green[900],
                                    fontWeight: FontWeight.bold
                                )
                            )
                        ),
                        Container(
                            height: 0.2*height,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap : (){
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                          return MyApp();
                                        }));
                                  },
                                  child: Text(
                                      "Menu principal"
                                  ),
                                ),

                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.person_pin, color: Colors.red)
                                  , onPressed: (){

                              }
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        width: width,
                        color: Colors.brown[50],
                        padding: EdgeInsets.all(20),
                        child:Column(
                          children : <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                      "Vous souhaitez vous inscrire en tant que : "
                                  ),
                                  SizedBox(width: 30),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _onPro = null;
                                          _onUser = 0 ;
                                        });
                                      }
                                      ,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        width: 130,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: _onPro == null ? Colors.red : Colors.green[900]

                                        ),
                                        child : Text(
                                            'Professionnel',
                                            style: new TextStyle(color: Colors.white,
                                              fontSize: 14,
                                            )
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _onPro = 0 ;
                                          _onUser = null;
                                        });

                                      }
                                      ,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: 130,
                                        alignment: Alignment.center,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: _onUser == null ? Colors.red : Colors.green[900]

                                        ),
                                        child : Text(
                                            'Utilisateur',
                                            style: new TextStyle(color: Colors.white,
                                              fontSize: 14,
                                            )
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Stack(
                              children: [
                                //------------------------------------------------------------------------------------------- Register User
                                SizedBox(
                                    width: 500,
                                    height: _onUser,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Date de naissance : ",
                                            ),
                                            Container(
                                                height: 80,
                                                width: 300,
                                                child : CupertinoDatePicker(
                                                  onDateTimeChanged: (DateTime date) {
                                                    _birthdate = date;
                                                  },
                                                  use24hFormat: false,
                                                  mode: CupertinoDatePickerMode.date,
                                                )
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text(
                                              'Pays :',
                                              style: TextStyle(
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            CountryCodePicker(
                                              initialSelection: 'FRANCE',
                                              showCountryOnly: true,
                                              showOnlyCountryWhenClosed: true,
                                              textStyle: TextStyle(color: Colors.blue),
                                              onChanged: (CountryCode country){
                                                sCountry = country.name;
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                            children: [
                                              Container(
                                                width : 300,
                                                margin: EdgeInsets.fromLTRB(0,0,15,0),
                                                child : TextField(
                                                  controller: _cityController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Ville',
                                                      hintStyle: TextStyle(
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child : TextField(
                                                  controller: _postalCodeController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Code Postal',
                                                      hintStyle: TextStyle(
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                  ),
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.number,
                                                ),

                                              ),
                                            ]
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : firstNameController,
                                          decoration: InputDecoration(
                                              hintText: 'Prénom',
                                              hintStyle: TextStyle(
                                              )
                                          ),
                                          style: TextStyle(
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          controller : lastNameController,
                                          decoration: InputDecoration(
                                              hintText: 'Nom de famille',
                                              hintStyle: TextStyle(
                                              )
                                          ),
                                          style: TextStyle(
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : loginController,
                                          decoration: InputDecoration(
                                              hintText: 'Login',
                                             
                                          ),

                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : mailController,
                                          decoration: InputDecoration(
                                            hintText: 'Adresse e-mail',
                                            // hintStyle: TextStyle(
                                            //   color : Color(_myColors.getColorGrey())
                                            // )
                                          ),
                                          // style: TextStyle(
                                          //     color: Color(_myColors.getColorGreyClear())
                                          // ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                            height: 30
                                        ),
                                        Row(
                                            children : <Widget>[
                                              Container(
                                                  width: 300,
                                                  child: TextField(
                                                    controller: pwdController,
                                                    decoration: InputDecoration(
                                                      hintText: 'Password',
                                                      // hintStyle: TextStyle(
                                                      //     color : Color(_myColors.getColorGrey())
                                                      // )
                                                    ),
                                                    // style: TextStyle(
                                                    //     color: Color(_myColors.getColorGreyClear())
                                                    // ),
                                                    maxLines: 1,
                                                    obscureText: bPasswordHidden,
                                                  )
                                              ),

                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 100,
                                                  child : IconButton(
                                                    padding: EdgeInsets.all(5),
                                                      icon : mVisiblePassword,
                                                      onPressed: (){
                                                        log("Password hidden : " + bPasswordHidden.toString());
                                                        _setIconPassword();
                                                      }
                                                  )
                                              )

                                            ]),
                                        SizedBox(height: 50),
                                        //ErrorMessage
                                        Text(
                                            sErrorMessage,
                                            style: new TextStyle(color: Colors.red)
                                        ),
                                        SizedBox(height: 10),

                                        // Login Button
                                        InkWell(
                                            onTap: () {
                                              _registerUser();
                                            }
                                            ,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.green[900]

                                              ),
                                              child : Text(
                                                  "S'inscrire",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontSize: 14,
                                                  )
                                              ),
                                            )
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                          value: dCircleValue,
                                        )
                                      ],
                                    )
                                ),
                                // ------------------------------------------------------------------------------------------------------------------------- Register Pro
                                SizedBox(
                                  width: 500,
                                  height: _onPro,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Type de commerçant"
                                            ),
                                            Container(
                                                height: 150,
                                                width: 200,
                                                child : CupertinoPicker(itemExtent: 50,
                                                    onSelectedItemChanged: (value){
                                                      setState(() {
                                                        _nSelect = value;
                                                      });

                                                    },
                                                    children: [
                                                      Align(alignment : Alignment.center,
                                                          child :
                                                          Text('Artisan'
                                                            , style: TextStyle(color: _nSelect == 0 ? Colors.blueAccent : Colors.black),
                                                          )
                                                      ),

                                                      Align(
                                                        alignment : Alignment.center,
                                                        child :Text('Boucher'
                                                            , style: TextStyle(color: _nSelect == 1 ? Colors.blueAccent : Colors.black),
                                                            textAlign: TextAlign.center),
                                                      ),
                                                      Align(alignment : Alignment.center,
                                                        child : Text('Traiteur'
                                                            , style: TextStyle(color: _nSelect == 2 ? Colors.blueAccent : Colors.black),
                                                            textAlign: TextAlign.center),
                                                      ),
                                                      Align(alignment : Alignment.center,
                                                          child : Text('Vestimentaire'
                                                              , style: TextStyle(color: _nSelect == 3 ? Colors.blueAccent : Colors.black),
                                                              textAlign: TextAlign.center)
                                                      )
                                                    ]
                                                )
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date de naissance : ",
                                            ),
                                            Container(
                                                height: 80,
                                                width: 300,
                                                child : CupertinoDatePicker(
                                                  onDateTimeChanged: (DateTime date) {
                                                    _birthdatePro = date;
                                                  },
                                                  use24hFormat: false,
                                                  mode: CupertinoDatePickerMode.date,
                                                )
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text(
                                              'Pays :',
                                              style: TextStyle(
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            CountryCodePicker(
                                              initialSelection: 'FRANCE',
                                              showCountryOnly: true,
                                              showOnlyCountryWhenClosed: true,
                                              textStyle: TextStyle(color: Colors.blue),
                                              onChanged: (CountryCode country){
                                                sCountry = country.name;
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                            children: [
                                              Container(
                                                width : 300,
                                                margin: EdgeInsets.fromLTRB(0,0,15,0),
                                                child : TextField(
                                                  controller: _cityControllerPro,
                                                  decoration: InputDecoration(
                                                      hintText: 'Ville',
                                                      hintStyle: TextStyle(
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child : TextField(
                                                  controller: _postalCodeControllerPro,
                                                  decoration: InputDecoration(
                                                      hintText: 'Code Postal',
                                                      hintStyle: TextStyle(
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                  ),
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.number,
                                                ),

                                              ),
                                            ]
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : firstNameControllerPro,
                                          decoration: InputDecoration(
                                              hintText: 'Prénom',
                                              hintStyle: TextStyle(
                                              )
                                          ),
                                          style: TextStyle(
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          controller : lastNameControllerPro,
                                          decoration: InputDecoration(
                                              hintText: 'Nom de famille',
                                              hintStyle: TextStyle(
                                              )
                                          ),
                                          style: TextStyle(
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : loginControllerPro,
                                          decoration: InputDecoration(
                                            hintText: 'Login',

                                          ),

                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 20,),
                                        TextField(
                                          controller : mailControllerPro,
                                          decoration: InputDecoration(
                                            hintText: 'Adresse e-mail',
                                            // hintStyle: TextStyle(
                                            //   color : Color(_myColors.getColorGrey())
                                            // )
                                          ),
                                          // style: TextStyle(
                                          //     color: Color(_myColors.getColorGreyClear())
                                          // ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                            height: 30
                                        ),
                                        Row(
                                            children : <Widget>[
                                              Container(
                                                  width: 300,
                                                  child: TextField(
                                                    controller: pwdControllerPro,
                                                    decoration: InputDecoration(
                                                      hintText: 'Password',
                                                      // hintStyle: TextStyle(
                                                      //     color : Color(_myColors.getColorGrey())
                                                      // )
                                                    ),
                                                    // style: TextStyle(
                                                    //     color: Color(_myColors.getColorGreyClear())
                                                    // ),
                                                    maxLines: 1,
                                                    obscureText: bPasswordHidden,
                                                  )
                                              ),

                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  child : IconButton(
                                                      padding: EdgeInsets.all(5),
                                                      icon : mVisiblePassword,
                                                      onPressed: (){
                                                        log("Password hidden : " + bPasswordHidden.toString());
                                                        _setIconPassword();
                                                      }
                                                  )
                                              )

                                            ]),
                                        SizedBox(height: 50),
                                        //ErrorMessage
                                        Text(
                                            sErrorMessage,
                                            style: new TextStyle(color: Colors.red)
                                        ),
                                        SizedBox(height: 10),

                                        // Login Button
                                        InkWell(
                                            onTap: () {
                                              _registerUser();
                                            }
                                            ,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.green[900]

                                              ),
                                              child : Text(
                                                  "S'inscrire",
                                                  style: new TextStyle(color: Colors.white,
                                                    fontSize: 14,
                                                  )
                                              ),
                                            )
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                          value: dCircleValue,
                                        )
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  )
                ])

        )
    );
  }

}