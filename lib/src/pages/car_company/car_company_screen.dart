import 'package:car_app/src/configs/constants/app_colors.dart';
import 'package:car_app/src/configs/constants/app_styles.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../configs/constants/constants.dart';
import '../../configs/widget/empty/empty.dart';
import '../../configs/widget/filed_search/textfile_search.dart';
import '../../models/company_car_model.dart';
import 'car_company.dart';
import 'components/components.dart';

class CarCompanyScreen extends StatefulWidget {
  const CarCompanyScreen({super.key});

  @override
  State<CarCompanyScreen> createState() => _CarCompanyScreenState();
}

class _CarCompanyScreenState extends State<CarCompanyScreen> {

  CarCompanyViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    final dataCar= ModalRoute.of(context)?.settings.arguments;
    return BaseWidget(
      viewModel: CarCompanyViewModel(), 
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(dataCar as CompanyCarModel?),
      builder: (context, viewModel, child) => buildCarCompanyScreen(),
    );
  }

  Widget buildAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: Paragraph(
        content: _viewModel!.listCar!.companyCar,
        style: STYLE_BIG.copyWith(
          color: AppColors.BLACK_500,
          fontWeight: FontWeight.w600
        )
      ),
    );
  }

   Widget buildFieldSearch(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeVeryVerySmall, 
        bottom: SizeToPadding.sizeMedium),
      child: TextFieldSearch(
        onChange: (value) => _viewModel!.searchCar(value),
      ),
    );
  }

  Widget buildListCar(){
    return _viewModel!.foundCar== null?
      Padding(
        padding: EdgeInsets.only(top: SizeToPadding.sizeBig * 7),
        child: const EmptyDataWidget(
          title: 'Hãng xe này trống',
          content: 'Hiện tại chưa có xe nào. Vui lòng quay lại sau!',
        ),
      )
      : SizedBox(
      height: MediaQuery.sizeOf(context).height-180,
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
        itemCount: _viewModel!.foundCar?.length,
        itemBuilder: (context, index) => InfoCarWidget(
          car: _viewModel!.foundCar?[index],
          onTap: () => _viewModel!.goToCarDetail(index),
        ),
      ),
    );
  }

  Widget buildCarCompanyScreen(){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Column(
            children: [
              buildAppBar(),
              buildFieldSearch(),
              buildListCar(),
            ],
          ),
        ),
      ),
    );
  }
}