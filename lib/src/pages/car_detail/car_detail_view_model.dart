import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/pages/routers.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import 'components/components.dart';

class CarDetailsViewModel extends BaseViewModel{
  final pageController = PageController(initialPage: 0);

  double currentPageValue = 0;

  CarModel? carModel;

  bool isFavorite=false;

  Future<void> init(CarModel? car)async{
    carModel=car;
    initPage();
    notifyListeners();
  }

  Future<void> goToBookingCar()=> Navigator.pushNamed(
    context, Routers.carBooking, arguments: carModel);

  void initPage(){
    pageController.addListener(() {
      currentPageValue = pageController.page!;
      notifyListeners();
    });
  }

  void setFavorite(){
    isFavorite=!isFavorite;
    notifyListeners();
  }

  Widget setSmooth(){
    if(carModel!=null){
      return SmoothWidget(
        controller: pageController,
        count: carModel!.image?.length ?? 0,
      );
    }else{
      return Container();
    }
  }
}