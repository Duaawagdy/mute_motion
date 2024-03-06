import 'dart:ui';

const kprimaryColor= Color(0xffFFFFFF);
const borderColor= Color(0xff003248);
String? userEmail;
setUserEmail(String? mail) => userEmail = mail;
String? getUserEmail() {
  return userEmail;
}