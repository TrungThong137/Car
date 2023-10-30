import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/widget/diaglog/dialog.dart';
import 'package:car_app/src/configs/widget/loading_dialog/loading_dialog.dart';
import 'package:car_app/src/models/car_booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CarOrderViewModel extends BaseViewModel{
  List<CarBookingModel> listCar=[];
  List<CarBookingModel> foundCar=[];

  ShowDialog showDialog= ShowDialog();

  dynamic init(){
    getListCar();
    notifyListeners();
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

  void clearData(){
    listCar.clear();
    foundCar.clear();
    notifyListeners();
  }

  void deleteCar(int index){
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    final id=foundCar[index].id;
    FirebaseFirestore.instance.collection('carBooking').doc(id).delete()
    .then((value) {
      addDataNotification(foundCar[index]);
    }).catchError((onError)=> showDialog.showErrorDialog(context));
  }

  void addDataNotification(CarBookingModel car){
    FirebaseFirestore.instance.collection('notification').add({
        'id': car.id,
        'idUser': FirebaseAuth.instance.currentUser!.uid,
        'detail': car.detail,
        'name': car.name,
        'image': car.image,
        'price': car.price,
        'note': car.note,
        'address': car.address,
        'nameUser': car.nameUser,
        'email': car.email,
        'phone': car.phone,
        'status': 'delete'
      }).then((data) {
        LoadingDialog.hideLoadingDialog(context);
        showDialog.showSuccessDialog(context);
        clearData();
        getListCar();
      })
    .catchError((onError){
      LoadingDialog.hideLoadingDialog(context);
      showDialog.showErrorDialog(context);
    });
  }
}