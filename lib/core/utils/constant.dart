import 'dart:ui';

const kprimaryColor= Color(0xffFFFFFF);
const borderColor= Color(0xff003248);
String? userEmail;
String? userName;
String? userPhoto;
setUserEmail(String? mail) => userEmail = mail;
String? getUserEmail() {
  return userEmail;
}
setUserName(String? name) => userName = name;
String? getUserName() {
  return userName;
}
setUserPhoto(String? photo) => userPhoto = photo;
String? getUserPhoto() {
  return userPhoto;
}