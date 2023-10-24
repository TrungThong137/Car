class Users {
  Users({
    this.idUser,
    this.fullName,
    this.emailAddress,
    this.pass,
    this.phone,
  });

  final String? idUser;
  final String? fullName;
  final String? emailAddress;
  final String? pass;
  final String? phone;

  static Users fromJson(Map<String, dynamic> json) => Users(
        idUser: json['id'],
        fullName: json['name'],
        emailAddress: json['email'],
        pass: json['password'],
        phone: json['phone']
      );

  Map<String, dynamic> toJson() => {
        'id': idUser,
        'name': fullName,
        'email': emailAddress,
        'password': pass,
        'phone': phone
      };
}
