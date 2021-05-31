import 'package:flutter/material.dart';
import 'package:mci_web_project/MyProfile/MyProProfile_Model.dart';
import 'MyProProfile_Model.dart';
import 'package:mci_web_project/Common/Product.dart';
import 'package:mci_web_project/Common/Professional.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';


class MyProfile_View extends StatefulWidget {

  @override
  MyProfile_State createState() => MyProfile_State();

}

class MyProfile_State extends State<MyProfile_View>{
  MyProProfile_Model _mpModel = new MyProProfile_Model();
  List<Product> _listProduct = new List();
  double _listIsEmpty = 0;
  bool _isHere = false;
  String _sIDPro;
  String _sLogin = "";
  String _sName = "";
  String _sProfession = "";
  String _sDescription = "";
  String _sCity = "" ;
  Image _profilePicture = Image.asset("assets/image/profile_picture.jpg");

  @override
  void initState() {
    _mpModel = MyProProfile_Model();
    getDATA();
    loadProfilePicture();
    getListProduct();
  }

  void getDATA() async{
    bool _bResult = await _mpModel.getDATAFromFirestore();
    if(_bResult){
      setState(() {
        _sLogin = _mpModel.getLogin();
        _sName = _mpModel.getFirstName() + " " + _mpModel.getLastName();
        _sProfession = _mpModel.getProfession();
        _sDescription = _mpModel.getDescription();
        _isHere = _mpModel.getIsHere();
        _sCity = _mpModel.getCity();
      });
    }
  }

  void loadProfilePicture() async{
    bool _bResult = await _mpModel.downloadProfilePicture();
    if(_bResult){
      setState(() {
        _profilePicture = Image.network(_mpModel.getProfilePicture());
      });
    }
  }

  void getListProduct() async{
    bool bResult = await _mpModel.getListProductFromFirebase();
    log(bResult.toString());
    if(bResult){
      setState(() {
        _listProduct = _mpModel.getListProduct();
        if(_listProduct.isEmpty){
          _listIsEmpty = null;
        }
        else{
          _listIsEmpty = 0 ;
        }
      });
    }
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            SizedBox(
                              width: 50,
                            ),
                            InkWell(
                              onTap: (){
                                logout();
                              },
                              child:  Container(
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
                                            "Se déconnecter"
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            )

                          ],
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.person_pin, color: Colors.red,)
                                  , onPressed: (){

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
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _sName,
                                              style: TextStyle(
                                                  color: Colors.green[900],
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              _sProfession,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16
                                              ),
                                            ),

                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              _sDescription,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 22
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                      ),
                                      Container(
                                          width: 500,
                                          child: Image(
                                            image: new AssetImage("assets/image/profile_picture.jpg"),
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
                                      "Produits proposés",
                                      style: TextStyle(
                                          color : Colors.green[900],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
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
                                              alignment: Alignment.topCenter,
                                              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                              child: Text(
                                                "Vous n'avez ajouté aucun produit.",
                                                style: TextStyle(
                                                    fontSize: fontSize1
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                              child:  GridView(
                                                  physics: const BouncingScrollPhysics(),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                  children: _listProduct.
                                                  map((_product) =>
                                                      Card(
                                                          child: Container(
                                                            height: 0.5*height,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 400,
                                                                  width: 200,
                                                                  // child:  Image(image:_professionnel.getProfilePicture() != "" ? Image.network(_professionnel.getProfilePicture()).image : AssetImage("assets/image/profile_picture.jpg"),
                                                                  child: Image(image : AssetImage("assets/image/profile_picture.jpg")),
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.all(3),
                                                                      child: Text(
                                                                        _product.getNameProduct(),
                                                                        style: TextStyle(
                                                                            fontSize: 18
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.all(3),
                                                                      child: Text(
                                                                        _product.getDescriptionProduct(),
                                                                        style: TextStyle(
                                                                            color : Colors.red,
                                                                            fontSize: 14
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        _product.getPrice().toString() + "€"
                                                                    )
                                                                  ],
                                                                )

                                                              ],
                                                            ),
                                                          )
                                                      )
                                                  ).toList()

                                              ),
                                            )

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
                ]
            )
        )
    );
  }

}