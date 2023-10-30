import 'dart:async';

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/widget/diaglog/dialog.dart';
import 'package:car_app/src/configs/widget/loading_dialog/loading_dialog.dart';
import 'package:car_app/src/models/car_booking_model.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/pages/utils/app_valid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class CarBookingViewModel extends BaseViewModel{

  CarModel? carModel;

  ShowDialog show= ShowDialog();

  TextEditingController phoneController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController fullNameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController noteController= TextEditingController();

  String? messageEmail;
  String? messageFullName;
  String? messagePhone;
  String? messageAddress;

  bool enableButton=false;

  Timer? timer;

  dynamic init(CarModel? car){
    carModel=car;
    notifyListeners();
  }

  Future<void> goToBookingDetail(Map<String, dynamic> data)=> Navigator.pushNamed(
    context, Routers.carBookingDetail, arguments: CarBookingModel.fromJson(data));

  void validAddress(String value) {
    final result= AppValid.validAddress(value);
    if (result!=null) {
      messageAddress = result;
    } else {
      messageAddress = null;
    }
    notifyListeners();
  }

   void validPhone(String? value) {
    final result = AppValid.validatePhoneNumber(value);
    if (result != null) {
      messagePhone = result;
    } else {
      messagePhone = null;
    }
    notifyListeners();
  }

  void validFullName(String? value) {
    final result = AppValid.validateFullName(value);
   if (result != null) {
      messageFullName = result;
    } else {
      messageFullName = null;
    }
    notifyListeners();
  }

   void validEmail(String? value) {
    final result = AppValid.validateEmail(value);
    if (result != null) {
      messageEmail = result;
    } else {
      messageEmail = null;
    }
    notifyListeners();
  }

  void onConfirm() {
    if (messageFullName==null && messagePhone==null 
      && messageEmail==null && messageAddress==null) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> dataToPush() => {
    'detail': carModel?.detail,
  };

  void bookingCar(){
    LoadingDialog.showLoadingDialog(context, 'Loading....');
    FirebaseFirestore.instance.collection('carBooking').add(dataToPush())
    .then((value) {
      final id= value.id;
      Map<String, dynamic> data() => {
        'id': id,
        'idUser': FirebaseAuth.instance.currentUser!.uid,
        'detail': carModel?.detail,
        'name': carModel?.name,
        'image': carModel?.image,
        'price': carModel?.price,
        'note': noteController.text.trim(),
        'address': addressController.text.trim(),
        'nameUser': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      };
      final infoUser= data();
      FirebaseFirestore.instance.collection('carBooking').doc(id).set(
        data()).then((data) {
          LoadingDialog.hideLoadingDialog(context);
          show.showSuccessDialog(context);
          timer= Timer(const Duration(seconds: 2), ()=> goToBookingDetail(infoUser));
        })
      .catchError((onError){
        LoadingDialog.hideLoadingDialog(context);
        show.showErrorDialog(context);
      });
    })
    .catchError((onError){
      LoadingDialog.hideLoadingDialog(context);
      show.showErrorDialog(context);
    });
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    noteController.dispose();
    timer?.cancel();
    super.dispose();
  }
}