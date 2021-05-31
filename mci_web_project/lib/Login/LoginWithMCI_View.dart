import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'LoginWithMCI_Controller.dart';
import 'dart:developer';
import 'package:mci_web_project/Resources/UnicornOutlineButton.dart';
import 'package:mci_web_project/MyProfile/MyProfile_View.dart';
import 'Register/Register_View.dart';

class LoginWithMCI_View extends StatefulWidget {

  @override
  LoginWithMCI_State createState() => LoginWithMCI_State();

}

class LoginWithMCI_State extends State<LoginWithMCI_View>{
  Icon mVisiblePassword = Icon(FontAwesomeIcons.eyeSlash, color: Colors.blueAccent);
  bool bPasswordHidden = true;
  String sErrorMessage = "";
  double dCircleValue = 0;
  LoginWithMCI_Controller loController = new LoginWithMCI_Controller();
  final pwdController = TextEditingController();
  final mailController = TextEditingController();

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

  void _loginResult() async {
    setState(() {
      dCircleValue = null;
      sErrorMessage = "";
    });

    log("set state");

    final bResult = await loController.signIn(mailController.text, pwdController.text);

    log("set state");
    setState(() {
      //if login is successful
      log("bResult : " + bResult.toString());
      if(bResult[0] == true){
        // check if it's a pro or an user
        if(bResult[1]){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MyProfile_View();
          }));
        }
        else{
          //user
          // sErrorMessage = "User";
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          //   return MainApp_View(isPro: false,);
          // }));
        }
        // sErrorMessage = "Bienvenue";
      }
      else{
        sErrorMessage = "Erreur de connexion";
      }
      dCircleValue = 0;

    });
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
                                        Navigator.pop(context);
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
              SizedBox(height: 100,),
              Container(
                width: 500,
                child:Column(
                  children : <Widget>[
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
                            width: 15,
                          ),
                          Container(
                              child : IconButton(
                                  icon : mVisiblePassword,
                                  onPressed: (){
                                    log("Password hidden : " + bPasswordHidden.toString());
                                    _setIconPassword();
                                  }
                              )
                          )

                        ])
                  ],
                ),

              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return Register_View();
                      }));
                },
                child : Text(
                  "Pas encore inscrit ? Inscrivez-vous dès maintenant en cliquant ici !",
                  style: TextStyle(
                    decoration: TextDecoration.underline
                  ),
                )
              ),
              SizedBox(height: 100),
              //ErrorMessage
              Text(
                  sErrorMessage,
                  style: new TextStyle(color: Colors.red)
              ),
              SizedBox(height: 10),

              // Login Button
              InkWell(
                  onTap: () {
                    _loginResult();
                  }
                  ,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[900]

                    ),
                    child : Text(
                            'Se connecter',
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
            ])

        )
    );
  }

}