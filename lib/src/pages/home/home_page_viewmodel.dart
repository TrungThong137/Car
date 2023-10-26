import 'dart:async';

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/models/company_car_model.dart';
import 'package:car_app/src/models/list_car_model.dart';
import 'package:car_app/src/models/user.dart';
import 'package:car_app/src/pages/routers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends BaseViewModel{
  List<Car> listCar=[];
  List<CarModel> foundCar=[];
  List<CarModel> listCarModel=[];
  CompanyCarModel? listCarBMW;
  CompanyCarModel? listCarHonda;
  CompanyCarModel? listCarToyota;
  CompanyCarModel? listCarMec;
  CompanyCarModel? listCarVolvo;
  CompanyCarModel? listCarJaguar;

  Users? user;

  final PageController controller = PageController(initialPage: 0);
  int isIndex=0;
  bool isActive=false;
  int indexCompanyCar=0;
  int currentIndex=0;
  Timer? timer;
  String? name;

  final currentUser = FirebaseAuth.instance.currentUser;
  
  dynamic init() async{
    fetchUserInfo();
    getAllCar();
    notifyListeners();
  }

  Future<void> goToTopDetails() =>Navigator.pushNamed(
    context, Routers.topDetails, arguments: ListCarModel(
      listCarAll: listCarModel,
      listCarBMW: listCarBMW,
      listCarHonda: listCarHonda,
      listCarJaguar: listCarJaguar,
      listCarMec: listCarMec,
      listCarToyota: listCarToyota,
      listCarVolvo: listCarVolvo
    ));

  void getAllCar() async{
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
      listCarBMW = CompanyCarModel(
        carModel: car,
        companyCar: 'BMW'
      );
      listCarModel=car;
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
      listCarMec = CompanyCarModel(
        carModel: car,
        companyCar: 'Mercedes'
      );
      listCarModel.addAll(car);      
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
      listCarHonda = CompanyCarModel(
        carModel: car,
        companyCar: 'Honda'
      );
      listCarModel.addAll(car);
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
      listCarToyota = CompanyCarModel(
        carModel: car,
        companyCar: 'ToyoTa'
      );
      listCarModel.addAll(car);
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
      listCarVolvo = CompanyCarModel(
        carModel: car,
        companyCar: 'VolVo'
      );
      listCarModel.addAll(car);
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
      listCarJaguar = CompanyCarModel(
        carModel: car,
        companyCar: 'Jaguar'
      );
      listCarModel.addAll(car);
      notifyListeners();
    });
  }

  Future<void> fetchUserInfo() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where("id", isEqualTo: currentUser!.uid)
        .get();
    final userData = snapshot.docs.map((e) => e.data()).single;
    user= Users.fromJson(userData);
    print(user?.fullName);
    notifyListeners();
  }

  void runFilter(String enteredKeyword){
    List<CarModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = listCarModel;
    } else {
      results = listCarModel
        .where((user) =>
        user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
    }
    foundCar=results;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }
}