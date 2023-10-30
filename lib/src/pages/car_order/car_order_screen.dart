// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/empty/empty.dart';
import '../../configs/widget/filed_search/textfile_search.dart';
import 'car_order.dart';
import 'components/components.dart';

class CarOrderScreen extends StatefulWidget {
  const CarOrderScreen({super.key});

  @override
  State<CarOrderScreen> createState() => _CarOrderScreenState();
}

class _CarOrderScreenState extends State<CarOrderScreen> {

  CarOrderViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      viewModel: CarOrderViewModel(),
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(),
      builder: (context, viewModel, child) => buildScreen(),
    );
  }

  Widget buildAppBar(){
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        top: 14,
        bottom: 10,
        left: SizeToPadding.sizeMedium,
        right: SizeToPadding.sizeMedium,
      ),
      color: AppColors.BLACK_500,
      child: Paragraph(
        content: 'Xe đã đặt',
        textAlign: TextAlign.center,
        style: STYLE_LARGE.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.COLOR_WHITE
        ),
      )
    );
  }

  Widget buildFieldSearch(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall, 
        horizontal: SizeToPadding.sizeMedium),
      child: TextFieldSearch(
        onChange: (value) => _viewModel!.searchCar(value),
      ),
    );
  }

  Widget buildListCar(){
    return _viewModel!.foundCar== [] || _viewModel!.foundCar.isEmpty?
      Padding(
        padding: EdgeInsets.only(top: SizeToPadding.sizeBig * 7),
        child: const EmptyDataWidget(
          title: 'không tìm thấy',
          content: 'Hiện tại không có xe nào. Vui lòng quay lại sau!',
        ),
      )
      : Container(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall, 
        horizontal: SizeToPadding.sizeMedium),
      height: MediaQuery.sizeOf(context).height-220,
      width: double.maxFinite,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 250,
        ), 
        itemCount: _viewModel!.foundCar.length,
        itemBuilder: (context, index) => InfoCarWidget(
          car: _viewModel!.foundCar[index],
          onCancelOrder: (result) => _viewModel!.deleteCar(index),
        ),
      ),
    );
  }

  Widget buildScreen(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAppBar(),
            buildFieldSearch(),
            buildListCar(),
          ],
        ),
      ),
    );
  }
}