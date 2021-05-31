

class Product{
  String _idProduct,_sIDPro , _sNameProduct, _sDescription, _urlPictureProduct;
  var _price;

  Product(String _newIDProduct, String _newIDPro, String _newName, String _newDescription, var _newPrice, String _newUrlPictureProduct){
    _idProduct = _newIDProduct;
    _sNameProduct = _newName;
    _sDescription = _newDescription;
    _price = _newPrice;
    _urlPictureProduct = _newUrlPictureProduct;
    _sIDPro = _newIDPro;
  }


  String getIDProduct(){
    return _idProduct;
  }

  String getIDPro(){
    return _sIDPro;
  }

  String getNameProduct(){
    return _sNameProduct;
  }

  String getDescriptionProduct(){
    return _sDescription;
  }

  double getPrice(){
    return _price.toDouble();
  }

  String getURLPictureProduct(){
    return _urlPictureProduct;
  }
}