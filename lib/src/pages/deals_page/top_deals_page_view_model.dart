import 'package:car_app/src/models/list_car_model.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../models/car_model.dart';
import '../routers.dart';

class TopDealsPageViewModel extends BaseViewModel{
  ListCarModel? listCar;

  dynamic init(ListCarModel dataCar){
    listCar=dataCar;
  }

  Future<void> goToCarDetail(CarModel? carModel)=> Navigator.pushNamed(
    context, Routers.carDetail, arguments: carModel);
}