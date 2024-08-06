class UserModel {
  String email;
  String fullName;
  String address;
  String phoneNumber;
  String token;
  String imageLink;

  UserModel({
    required this.email,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.token,
    required this.imageLink,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      fullName: data['full_name'],
      address: data['address'],
      phoneNumber: data['phone_number'],
      token: data['token'],
      imageLink: data['image_link'],
    );
  }
}
