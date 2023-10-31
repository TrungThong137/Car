import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:car_app/src/firebase/firestore.dart';
import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/configs/widget/discount_car.dart';
import 'package:car_app/src/pages/home/components/components.dart';
import 'package:car_app/src/configs/widget/logocar.dart';
import 'package:car_app/src/configs/widget/filed_search/textfile_search.dart';
import 'package:car_app/src/configs/widget/title_row/title_row.dart';
import 'package:car_app/src/pages/home/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/car_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // void autoShowCar(){
  //   timer = Timer.periodic(
  //     const Duration(seconds: 2), (timer) { 
  //     if(currentIndex<car.length-1){
  //       currentIndex++;
  //     }else{
  //       currentIndex=0;
  //     }
  //     _controller.animateToPage(
  //       currentIndex,
  //       duration: const Duration(milliseconds: 200), 
  //       curve: Curves.bounceInOut
  //     );
  //   });
  // } 

  Widget listCars(List<CarModel> car){
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
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

  HomePageViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      viewModel: HomePageViewModel(), 
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(),
      builder: (context, viewModel, child) => buildHomeScreen(),);
  }

  Widget buildPageCarDiscount(AsyncSnapshot<List<Car>> snapshot){
    return PageView.builder(
      controller: _viewModel!.controller,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final car= snapshot.data![index];
          return DiscountCar(
            imageCar: car.imageCar,
            discount: car.discount,
          );
      },
    );
  }

  Widget buildDotPageDiscount(AsyncSnapshot<List<Car>> snapshot){
    return Positioned(
      bottom: 20,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 130),
        child: SmoothPageIndicator(
          controller: _viewModel!.controller, 
          count: snapshot.data!.length,
          effect: const ExpandingDotsEffect(
            spacing: 12,
            dotColor: Colors.grey,
            strokeWidth: 1,
            dotWidth: 7,
            dotHeight: 7,
            activeDotColor: Colors.black
          ),
          onDotClicked: (index) => _viewModel!.controller.animateToPage(
            index, 
            duration: const Duration(milliseconds: 500), 
            curve: Curves.linear
          ),
        ),
      ),
    );
  }

  Widget buildCarDiscount(){
    return Container(
      margin: const EdgeInsets.only(top: 250, left: 20, right: 20),
      width: double.maxFinite,
      height: 200,
      child: StreamBuilder(
        stream: FireStore.readNewspaper(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Stack(
              children:[
                buildPageCarDiscount(snapshot),

                buildDotPageDiscount(snapshot),
              ] 
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildNameUser(){
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.black,
      ),
      contentPadding: const EdgeInsets.only(left: 18, right: 20),
      title: Paragraph(content: _viewModel!.user?.fullName ?? '',
        style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w700),),
      trailing: SizedBox(
        width: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/notification-bing.svg'),
            const SizedBox(width: 12,),
            SvgPicture.asset('assets/heart.svg'),
          ],
        ),
      )
    );
  }

  Widget buildTabAll(){
    return listCars(_viewModel!.listCarModel);
  }

  Widget buildTabMec(){
    return listCars(_viewModel!.listCarMec?.carModel ?? []);
  }

  Widget buildTabBMW(){
    return listCars(_viewModel!.listCarBMW?.carModel ?? []);
  }

  Widget buildTabToyota(){
    return listCars(_viewModel!.listCarToyota?.carModel ?? []);
  }

  Widget buildTabVolvo(){
    return listCars(_viewModel!.listCarVolvo?.carModel ?? []);
  }

  Widget buildTabJaguar(){
    return listCars(_viewModel!.listCarJaguar?.carModel ?? []);
  }

  Widget buildTabHonda(){
    return listCars(_viewModel!.listCarHonda?.carModel ?? []);
  }

  Widget buildTabCar(){
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

  Widget buildListCarOfTab(){
    return SizedBox(
      height: 500,
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

  Widget buildFieldSearch(){
    return TextFieldSearch(
      onChange: (value) => _viewModel!.runFilter(value),
    );
  }

  Widget buildTitleDiscount(){
    return TitleRow(textLeft: "Special Offsers", 
      textRight: 'See All',
      onTap: (){},
    );
  }

  Widget buildTitleListCar(){
    return TitleRow(
      textLeft: 'Top Deals', 
      textRight: 'See All',
      onTap: ()=> _viewModel!.goToTopDetails(),
    );
  }

  Widget buildBody(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          buildFieldSearch(),
          const SizedBox(height: 20,),
          buildTitleDiscount(),
          const SizedBox(height: 230,),
          logoCars(),
          buildTitleListCar(),
          const SizedBox(height: 20,),
          buildTabCar(),
          buildListCarOfTab(),
        ],
      ),
    );
  }

  Widget buildHomeScreen(){
    return Scaffold(
      body: DefaultTabController(
        length: companyCar.length,
        child: SingleChildScrollView(
          child: Stack(
            children:[
              buildCarDiscount(),
              Column(
                children: [
                  const SizedBox(height: 50,),
                  const Paragraph(content: 'Welcome Back', color: AppColors.BLACK_500,),
                  buildNameUser(),
                  buildBody(),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget logoCars(){
    return SizedBox(
      height: 230,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 91
        ),
        itemCount: logoCar.length,
        itemBuilder: (context, index) => LogoCar(
          logoCar: logoCar[index].imageCar, 
          nameCar: logoCar[index].logoName,
          onTap: () => _viewModel!.setCarCompany(index),
        ),
      ),
    );
  }
}
