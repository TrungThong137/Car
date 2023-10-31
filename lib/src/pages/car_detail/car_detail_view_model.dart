import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/pages/routers.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import 'components/components.dart';

class CarDetailsViewModel extends BaseViewModel{
  final pageController = PageController(initialPage: 0);
  AnimationController? controller;
  Animation? colorAnimation;
  Animation<double>? sizeAnimation;

  double currentPageValue = 0;

  CarModel? carModel;

  bool isFavorite=false;

  Future<void> init(CarModel? car, dynamic dataThis)async{
    carModel=car;
    initPage();
    controller=AnimationController(
      duration: const Duration(milliseconds: 500), vsync: dataThis);
    colorAnimation = ColorTween(begin: AppColors.BLACK_500, end: AppColors.PRIMARY_RED)
      .animate(controller as Animation<double>);
    sizeAnimation =TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween(begin: 30, end: 50),
        weight: 50
      ),
      TweenSequenceItem(
        tween: Tween(begin: 50, end: 30),
        weight: 50
      )
    ]).animate(controller!);
    controller?.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        isFavorite=true;
        notifyListeners();
      }else{
        isFavorite=false;
        notifyListeners();
      }
    });
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

  @override
  void dispose() {
    pageController.dispose();
    
    controller?.dispose();
    super.dispose();
  }
}