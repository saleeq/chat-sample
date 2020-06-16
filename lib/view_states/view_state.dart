import 'package:flutter/foundation.dart';

class ViewState extends ChangeNotifier{

  void setState(){
    notifyListeners();
  }

}