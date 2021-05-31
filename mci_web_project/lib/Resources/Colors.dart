//This class perms to list colors and get their values

class MyColors {
  int _colorBackgroundDark, _colorDarkBlue, _colorBackgroundPurple , _colorPink, _colorGreyDark, _colorGrey, _colorGreyClear, _colorGreen, _colorError;
  int _colorBlueClear, _colorBlueCyan, _colorBlack, _colorPinkFlash, _colorGreenDark;

  MyColors(){
    _colorBackgroundDark     = 0xFF252525;
    _colorDarkBlue           = 0xFF3700B3;
    _colorBackgroundPurple   = 0xFF460950;
    _colorPink               = 0xFFBEA2C0;
    _colorGreyDark           = 0xFF303030;
    _colorGrey               = 0xFF707070;
    _colorGreyClear          = 0xFFCCCCCC;
    _colorGreen              = 0xFF32C924;
    _colorError              = 0xFF850606;
    _colorBlueCyan           = 0xFF00BFFF;
    _colorBlueClear          = 0xFF2C75FF;
    _colorBlack              = 0xFF0F0F0F;
    _colorPinkFlash          = 0xFFFD5DA8;
    // _colorGreenDark          = 0xFF1E7B29;
    _colorGreenDark          = 0xFF175F1F;
  }

  int getColorGreenDark(){
    return _colorGreenDark;
  }

  int getColorBackgroundDark(){
    return _colorBackgroundDark;
  }

  int getColorDarkBlue(){
    return _colorDarkBlue;
  }

  int getColorBackgroundPurple(){
    return _colorBackgroundPurple;
  }

  int getColorPink(){
    return _colorPink;
  }

  int getColorGreyDark(){
    return _colorGreyDark;
  }

  int getColorGrey(){
    return _colorGrey;
  }

  int getColorGreyClear(){
    return _colorGreyClear;
  }

  int getColorError(){
    return _colorError;
  }

  int getColorBlueClear(){
    return _colorBlueClear;
  }

  int getColorBlueCyan(){
    return _colorBlueCyan;
  }

  int getColorBlack(){
    return _colorBlack;
  }

  int getColorPinkFlash(){
    return _colorPinkFlash;
  }

}
