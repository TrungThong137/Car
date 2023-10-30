class CarNotification{
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
  String? status;

  CarNotification({
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
    this.status,
  });

  static CarNotification fromJson(Map<String, dynamic> json) => CarNotification(
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
    status: json['status'] ?? '',
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
    'status': status
  };
}