import 'package:car_app/src/models/car_model.dart';

class CompanyCarModel{
  List<CarModel>? carModel;
  String? companyCar;

  CompanyCarModel({
    this.carModel,
    this.companyCar, 
  });

  static CompanyCarModel fromJson(Map<String, dynamic> json) => CompanyCarModel(
    carModel: json['carModel'] ?? '',
    companyCar: json['companyCar'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'carModel': carModel,
    'companyCar': companyCar,
  };
}