import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/models/car_booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CarOrderViewModel extends BaseViewModel{
  List<CarBookingModel> listCar=[];
  List<CarBookingModel> foundCar=[];

  dynamic init(){
    getListCar();
  }

  void searchCar(String value){
    if(value.isEmpty || value==''){
      foundCar=listCar;
    }else{
      foundCar= listCar.where((element) =>
        element.name!.toLowerCase().contains(value.toLowerCase()) 
        || element.price!.toLowerCase().contains(value.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  void getListCar(){
    final id= FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('carBooking')
    .where('idUser', isEqualTo: id)
    .snapshots()
    .map((snapshots) => snapshots.docs.map((car) {
      final data= car.data();
      return CarBookingModel.fromJson(data);
    }).toList()).listen((event) {
      listCar.addAll(event);
      foundCar=listCar;
      notifyListeners();
    });
  }
}