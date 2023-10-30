import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/models/car_booking_model.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class CarBookingDetailViewModel extends BaseViewModel{

  CarBookingModel? infoBooking;

  List<CarModel> listCar=[];

  dynamic init(CarBookingModel? info){
    infoBooking=info;
    getAllCar();
    notifyListeners();
  }

  Future<void> goToHome()=> 
    Navigator.pushReplacementNamed(context, Routers.bottomNavigatorScreen);

  Future<void> goToCarDetail(int index)=> Navigator.pushNamed(
    context, Routers.carDetail, arguments: listCar[index]);

  Future<void> goToCarBooking(int index)=> Navigator.pushNamed(
    context, Routers.carBooking, arguments: infoBooking);

  String? formatPhone(){
    String firstThreeDigits = infoBooking!.phone!.substring(0, 2); 
    String lastThreeDigits = infoBooking!.phone!.substring(infoBooking!.phone!.length - 3);
    final phone='(+84)$firstThreeDigits*****$lastThreeDigits';
    return phone;
  }

  Future<void> getAllCar() async{
    getCarBMW();
    getCarHonda();
    getCarJaguar();
    getCarMec();
    getCarToyota();
    getCarVolvo();
    notifyListeners();
  }

  void getCarBMW() async{
    FirebaseFirestore.instance
        .collection('BMW')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);
      notifyListeners();
    });
  }

  void getCarMec() async{
    FirebaseFirestore.instance
        .collection('mercedes')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);      
      notifyListeners();
    });
  }

  void getCarHonda() async{
    FirebaseFirestore.instance
        .collection('honda')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);
      notifyListeners();
    });
  }

  void getCarToyota() async{
    FirebaseFirestore.instance
        .collection('toyota')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);
      notifyListeners();
    });
  }

  void getCarVolvo() async{
    FirebaseFirestore.instance
        .collection('volvo')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);
      notifyListeners();
    });
  }

  void getCarJaguar() async{
    FirebaseFirestore.instance
        .collection('jaguar')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final data = doc.data();
              return CarModel.fromJson(data);
            }).toList())
        .listen((car) {
      listCar.addAll(car);
      notifyListeners();
    });
  }
}