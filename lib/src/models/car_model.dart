class CarModel{
  String? name;
  String? price;
  String? detail;
  List<dynamic>? image;
  bool isFavorite;

  CarModel({
    this.name,
    this.price, 
    this.detail,
    this.image,
    this.isFavorite=false
  });

  static CarModel fromJson(Map<String, dynamic> json) => CarModel(
    detail: json['detail'] ?? '',
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    price: json['price'] ?? '',
    isFavorite: json['isFavorite'],
  );

  Map<String, dynamic> toJson() => {
    'detail': detail,
    'name': name,
    'image': image,
    'isFavorite': isFavorite,
    'price': price,
  };
}