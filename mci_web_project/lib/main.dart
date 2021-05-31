import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'Common/Professional.dart';
import 'Main_Model.dart';
import 'ProfessionnelProfile/ProfessionnelProfile_View.dart';
import 'Login/LoginWithMCI_View.dart';
import 'MyProfile/MyProfile_View.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCI WEB',
      debugShowCheckedModeBanner: false,
      home: HomePage_View(),
    );
  }
}

class HomePage_View extends StatefulWidget {
  @override
  HomePage_State createState() => HomePage_State();

}

class HomePage_State extends State<HomePage_View>{
  List<Professional> _listProfessionnel = new List();
  double _listIsEmpty = 0;
  Main_Model _model = new Main_Model();
  int professionSelectionne = 1;


  @override
  void initState() {
    _getListPro("");
  }

  void _getListPro(String profession) async{
    bool _bResult = await _model.getListProFromFirebase(profession);
    if(_bResult == true){
      setState(() {
        _listProfessionnel = _model.getListPro();
      });
    }
    else{
      _listProfessionnel = new List();
      _listIsEmpty = null;
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
                          child: Text(
                              "Menu principal"
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.red,
                          width: 150,
                          height: 2,
                        )
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
                            icon: Icon(Icons.person_pin)
                            , onPressed: (){
                          if(FirebaseAuth.instance.currentUser != null){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return MyProfile_View();
                                }));
                          }else{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return LoginWithMCI_View();
                                }));
                          }
                        }
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
            Expanded(
                child : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.brown[50],
                          height: 500,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "MON COMMERCE ITINERANT",
                                      style: TextStyle(
                                        color: Colors.brown
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Une nouvelle",
                                      style: TextStyle(
                                          color: Colors.green[900],
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "façon de",
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "trouver ce que",
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "l'on cherche !",
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 300,
                                      child :
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.check,color: Colors.green[900],),
                                              Text(
                                                "Une option de Click & Collect",
                                                style: TextStyle(
                                                  color: Colors.green[900],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.check,color: Colors.green[900],),
                                              Text(
                                                "Une liste de commerçants inscrits",
                                                style: TextStyle(
                                                  color: Colors.green[900],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.check,color: Colors.green[900],),
                                              Text(
                                                "Une géolocalisation sur notre app",
                                                style: TextStyle(
                                                  color: Colors.green[900],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.check,color: Colors.green[900],),
                                              Text(
                                                "Un suivi de leurs horaires in-app",
                                                style: TextStyle(
                                                  color: Colors.green[900],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )

                                    )

                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Container(
                                width: 500,
                                child: Image(
                                  image: new AssetImage("assets/img/Logo-PPE_V2.png"),
                                  width: 200,
                                )
                              )
                            ],

                          )
                        ),

                        Container(
                          color: Colors.white,
                          height: 2000,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                "Nos commerçants",
                                style: TextStyle(
                                  color : Colors.green[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap : (){
                                      _getListPro("");
                                      setState(() {
                                        professionSelectionne = 1;
                                      });
                                    },
                                    child: Container(
                                      alignment : Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: professionSelectionne == 1 ? Colors.red : Colors.green[900]

                                      ),
                                      child :
                                      Text(
                                        'Voir tout',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),

                                      ),

                                    )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("boucher");
                                        setState(() {
                                          professionSelectionne = 2;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 2 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'boucher',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("traiteur");
                                        setState(() {
                                          professionSelectionne = 3;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 3 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'traiteur',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("boulanger");
                                        setState(() {
                                          professionSelectionne = 4;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 4 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'boulanger',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("vestimentaire");
                                        setState(() {
                                          professionSelectionne = 5;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 5 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'vestimentaire',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("bazar");
                                        setState(() {
                                          professionSelectionne = 6;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 6 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'bazar',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),
                                  InkWell(
                                      onTap : (){
                                        _getListPro("poissonnier");
                                        setState(() {
                                          professionSelectionne = 7;
                                        });
                                      },
                                      child: Container(
                                        alignment : Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: professionSelectionne == 7 ? Colors.red : Colors.green[900]

                                        ),
                                        child :
                                        Text(
                                          'poissonnier',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      )
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: _listIsEmpty,
                                        width: width,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: Text(
                                          "Aucun professionnel ne correspond aux critères.",
                                          style: TextStyle(
                                              fontSize: fontSize1
                                          ),
                                        ),
                                      ),
                                      GridView(
                                          physics: const BouncingScrollPhysics(),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                          children: _listProfessionnel.
                                          map((_professionnel) =>
                                              Card(
                                                  child: Container(
                                                    height: 0.5*height,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            height: 350,
                                                            width: 400,
                                                            child:  Image(
                                                                image:_professionnel.getProfilePicture() != "" ? Image.network(_professionnel.getProfilePicture()).image : AssetImage("assets/image/profile_picture.jpg"),
                                                            fit: BoxFit.cover,)
                                                            // child: Image(image : AssetImage("assets/image/profile_picture.jpg")),
                                                              // fit: BoxFit.cover,
                                                        ),
                                                          Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(3),
                                                              child: Text(
                                                                _professionnel.getFirstName() + " " + _professionnel.getLastName(),
                                                                style: TextStyle(
                                                                    fontSize: 18
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.all(3),
                                                              child: Text(
                                                                _professionnel.getProfession(),
                                                                style: TextStyle(
                                                                  color : Colors.red,
                                                                  fontSize: 14
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: (){
                                                                Navigator.push(context,
                                                                    MaterialPageRoute(builder: (context) {
                                                                      return ProfessionnelProfile_View(_professionnel.getIDUser());
                                                                    }));
                                                              },
                                                              child:
                                                              Container(
                                                                padding: EdgeInsets.all(3),
                                                                child: Text(
                                                                  "Voir la carte du commerçant",
                                                                  style: TextStyle(
                                                                      color : Colors.green[900],
                                                                      fontSize: 14,
                                                                    decoration: TextDecoration.underline
                                                                  ),
                                                                ),
                                                              ),
                                                            )

                                                          ],
                                                        )

                                                      ],
                                                    ),
                                                  )
                                              )
                                          ).toList()

                                      ),
                                    ],
                                  )

                              )
                            ],
                          ),
                        )
                      ],
                    )
                )
            )

          ],
        ),
      ),
    );
  }

}
