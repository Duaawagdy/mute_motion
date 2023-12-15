import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController typeCont = TextEditingController();
  TextEditingController colorCont = TextEditingController();
  TextEditingController modelCont = TextEditingController();
  TextEditingController numCont = TextEditingController();
  TextEditingController describeCont = TextEditingController();
}
