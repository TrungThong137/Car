import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/models/company_car_model.dart';

class ListCarModel{
  List<CarModel>? listCarAll;
  CompanyCarModel? listCarBMW;
  CompanyCarModel? listCarHonda;
  CompanyCarModel? listCarToyota;
  CompanyCarModel? listCarMec;
  CompanyCarModel? listCarVolvo;
  CompanyCarModel? listCarJaguar;

  ListCarModel({
    this.listCarAll,
    this.listCarBMW,
    this.listCarHonda,
    this.listCarJaguar,
    this.listCarMec,
    this.listCarToyota,
    this.listCarVolvo,
  });
}