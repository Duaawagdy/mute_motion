class ProfileModel {
  final String cartype;
  final String color;
  final String model;
  final String fullname;
  final String email;
  final String phone;
  final String age;
  
  ProfileModel({
    required this.cartype,
    required this.color,
    required this.model,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.age,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
  return ProfileModel(
    cartype: json['cartype'] ?? '', // Provide default value if null
    color: json['color'] ?? '', // Provide default value if null
    model: json['model'] ?? '', // Provide default value if null
    fullname: json['fullname'] ?? '', // Provide default value if null
    email: json['email'] ?? '', // Provide default value if null
    phone: json['phone'] ?? '', // Provide default value if null
    age: json['age'] ?? '', // Provide default value if null
  );
}
}