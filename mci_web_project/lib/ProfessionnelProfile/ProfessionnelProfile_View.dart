import 'package:flutter/material.dart';
import 'ProfessionalProfile_Model.dart';
import 'package:mci_web_project/Common/Product.dart';
import 'package:mci_web_project/Common/Professional.dart';


class ProfessionnelProfile_View extends StatefulWidget {
  String idPro;

  ProfessionnelProfile_View(String _newID){
    idPro = _newID ;
  }

  @override
  ProfessionnelProfile_State createState() => ProfessionnelProfile_State(idPro);

}

class ProfessionnelProfile_State extends State<ProfessionnelProfile_View>{
  ProfessionalProfile_Model _ppModel;
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
  int professionSelectionne = 1;
  List<Professional> _listProfessionnel = new List();



  ProfessionnelProfile_State(String _newIDPro){
    _sIDPro = _newIDPro;
    _ppModel = new ProfessionalProfile_Model(_sIDPro);
  }

  @override
  void initState() {
    getDATA();
    loadProfilePicture();
    getListProduct();
  }

  void getDATA() async{
    bool _bResult = await _ppModel.getDATAFromFirestore();
    if(_bResult){
      setState(() {
        _sLogin = _ppModel.getLogin();
        _sName = _ppModel.getFirstName() + " " + _ppModel.getLastName();
        _sProfession = _ppModel.getProfession();
        _sDescription = _ppModel.getDescription();
        _sProfession   = _ppModel.getProfession();
        _isHere = _ppModel.getIsHere();
        _sCity = _ppModel.getCity();
      });
    }
  }

  void loadProfilePicture() async{
    bool _bResult = await _ppModel.downloadProfilePicture();
    if(_bResult){
      setState(() {
        _profilePicture = Image.network(_ppModel.getProfilePicture());
      });
    }
  }

  void getListProduct() async{
    bool bResult = await _ppModel.getListProductFromFirebase();
    if(bResult){
      setState(() {
        _listProduct = _ppModel.getListProduct();
        if(_listProduct.isEmpty){
          _listIsEmpty = null;
        }
        else{
          _listIsEmpty = 0 ;
        }
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
                                  icon: Icon(Icons.person_pin)
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
                                padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
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
                                        height: 350,
                                          width: 400,
                                          child: Image(
                                            image:_profilePicture.image,
                                            fit: BoxFit.cover,)

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
                                              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "Aucun produit n'est disponible",
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
                                                                  height: 350,
                                                                  width: 400,
                                                                  child: Image(image:_product.getURLPictureProduct() != "" ? Image.network(_product.getURLPictureProduct()).image : AssetImage("assets/image/profile_picture.jpg"),
                                                            fit: BoxFit.fill,),
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