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
setUserName(String? name) => userName = name;
String? getUserName() {
  return userName;
}
setUserPhoto(String? photo) => userPhoto = photo;
String? getUserPhoto() {
  return userPhoto;
}
setDriverRating(String? rate) => diverRate = rate;
String? getDriverRating() {
  return diverRate;
}
setNumOfReviews(String? Reviews) => numOfReviews = Reviews;
String? getNumOfReviews() {
  return numOfReviews;
}