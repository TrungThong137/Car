import 'package:car_app/src/models/car_model.dart';

class CarBookingModel{
  String? name;
  String? price;
  String? detail;
  List<dynamic>? image;
  String? phone;
  String? nameUser;
  String? address;
  String? email;
  String? note;
  String? id;

  CarBookingModel({
    this.name,
    this.price, 
    this.detail,
    this.image,
    this.phone,
    this.nameUser,
    this.address,
    this.email,
    this.note,
    this.id,
  });

  static CarBookingModel fromJson(Map<String, dynamic> json) => CarBookingModel(
    detail: json['detail'] ?? '',
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    price: json['price'] ?? '',
    phone: json['phone'] ?? '',
    nameUser: json['nameUser'] ?? '',
    address: json['address'] ?? '',
    email: json['email'] ?? '',
    note: json['note'] ?? '',
    id: json['id'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'detail': detail,
    'name': name,
    'image': image,
    'price': price,
    'note': note,
    'address': address,
    'nameUser': nameUser,
    'email': email,
    'phone': phone,
    'id': id,
  };
}