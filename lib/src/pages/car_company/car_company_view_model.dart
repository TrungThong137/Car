import 'package:car_app/src/models/car_model.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../models/company_car_model.dart';
import '../routers.dart';

class CarCompanyViewModel extends BaseViewModel{
  CompanyCarModel? listCar;
  List<CarModel>? foundCar;

  dynamic init(CompanyCarModel? dataCar){
    listCar=dataCar;
    foundCar=listCar?.carModel;
  }

  Future<void> goToCarDetail(int index)=> Navigator.pushNamed(
    context, Routers.carDetail, arguments: foundCar![index]);

  void searchCar(String value){
    if(value.isEmpty || value==''){
      foundCar=listCar?.carModel;
    }else{
      foundCar= listCar?.carModel!.where((element) =>
        element.name!.toLowerCase().contains(value.toLowerCase()) 
        || element.price!.toLowerCase().contains(value.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
}