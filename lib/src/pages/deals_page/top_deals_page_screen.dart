import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/models/list_car_model.dart';
import 'package:car_app/src/pages/deals_page/top_deals_page.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../models/car_model.dart';
import 'components/components.dart';

class TopDealsPageScreen extends StatefulWidget {
  const TopDealsPageScreen({super.key});

  @override
  State<TopDealsPageScreen> createState() => _TopDealsPageScreenState();
}

class _TopDealsPageScreenState extends State<TopDealsPageScreen> {

  TopDealsPageViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    final dataCar= ModalRoute.of(context)?.settings.arguments;
    return BaseWidget(
      viewModel: TopDealsPageViewModel(), 
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(dataCar as ListCarModel),
      builder: (context, viewModel, child) => buildTopDetailsScreen(),
    );
  }

  Widget buildAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: const Text(
        'Top Deals',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget buildTabBar(){
    return TabBar(
      tabs: List.generate(companyCar.length, (index) => 
        Container(
          height: 30,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2)
          ),
          child: Text(companyCar[index].logoName),
        ),
      ),
      isScrollable: true,
      labelColor: Colors.white,
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      indicator: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      unselectedLabelColor: Colors.black,
    );
  }

  Widget listCars(List<CarModel> car){
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 250,
      ), 
      itemCount: car.length,
      itemBuilder: (context, index) => InfoCarWidget(
        car: car[index],
        onTap: () => _viewModel!.goToCarDetail(car[index]),
      ),
    );
  }

  Widget buildTabAll(){
    return listCars(_viewModel!.listCar!.listCarAll ?? []);
  }

  Widget buildTabMec(){
    return listCars(_viewModel!.listCar?.listCarMec!.carModel ?? []);
  }

  Widget buildTabBMW(){
    return listCars(_viewModel!.listCar?.listCarBMW!.carModel ?? []);
  }

  Widget buildTabToyota(){
    return listCars(_viewModel!.listCar?.listCarToyota!.carModel ?? []);
  }

  Widget buildTabVolvo(){
    return listCars(_viewModel!.listCar?.listCarVolvo!.carModel ?? []);
  }

  Widget buildTabJaguar(){
    return listCars(_viewModel!.listCar?.listCarJaguar!.carModel ?? []);
  }

  Widget buildTabHonda(){
    return listCars(_viewModel!.listCar?.listCarHonda!.carModel ?? []);
  }

  Widget buildTabBarView(){
    return Expanded(
      child: TabBarView(
        children: [
          buildTabAll(),
          buildTabMec(),
          buildTabBMW(),
          buildTabToyota(),
          buildTabVolvo(),
          buildTabJaguar(),
          buildTabHonda(),
        ]
      ),
    );
  }

  Widget buildTopDetailsScreen(){
    return DefaultTabController(
      length: companyCar.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Column(
            children: [
              buildAppBar(),
              const SizedBox(height: 5,),
              buildTabBar(),
              buildTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}