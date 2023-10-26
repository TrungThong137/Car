import 'package:car_app/src/models/list_car_model.dart';

import '../../configs/base/base.dart';

class TopDealsPageViewModel extends BaseViewModel{
  ListCarModel? listCar;

  dynamic init(ListCarModel dataCar){
    listCar=dataCar;
  }
}