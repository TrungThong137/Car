import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/models/car_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationViewModel extends BaseViewModel{

  List<CarNotification> listCar=[];

  dynamic init(){
    getListCar();
    notifyListeners();
  }

  void getListCar(){
    final id= FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('notification')
    .where('idUser', isEqualTo: id)
    .snapshots()
    .map((snapshots) => snapshots.docs.map((car) {
      final data= car.data();
      return CarNotification.fromJson(data);
    }).toList()).listen((event) {
      listCar.addAll(event);
      notifyListeners();
    });
  }
}