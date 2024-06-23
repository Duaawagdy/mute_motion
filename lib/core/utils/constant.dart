import 'dart:ui';

const kprimaryColor= Color(0xffFFFFFF);
const borderColor= Color(0xff003248);
const chatColorMe = Color(0xffffd700);
String? userEmail;
String? userName;
String? userPhoto;
String? diverRate;
String? numOfReviews;
setUserEmail(String? mail) => userEmail = mail;
String? getUserEmail() {
  return userEmail;
}
setUserPhoto(String? photo) => userPhoto = photo;
String? getUserPhoto() {
  return userPhoto;
}
