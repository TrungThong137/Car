import 'package:car_app/src/configs/widget/app_bar/custom_appbar.dart';
import 'package:car_app/src/configs/widget/button/button.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../configs/constants/constants.dart';
import '../../configs/widget/text/paragraph.dart';
import 'car_detail.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> 
  with SingleTickerProviderStateMixin{
  CarDetailsViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments;
    return BaseWidget(
      viewModel: CarDetailsViewModel(),
      onViewModelReady: (viewModel) =>
          _viewModel = viewModel!..init(car as CarModel?, this),
      builder: (context, viewModel, child) => buildDetailCar(),
    );
  }

  Widget buildHeader() {
    return CustomerAppBar(
      title: _viewModel!.carModel?.name,
      onTap: () => Navigator.pop(context),
    );
  }

  Widget buildImage(int index) {
    final image = _viewModel?.carModel!.image?[index];
    return Padding(
      padding: EdgeInsets.only(top: SpaceBox.sizeMedium),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(BorderRadiusSize.sizeMedium)),
        child: Image.network(
          image ??
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmVfPm6hKZTky6SpTNvEZqaqa8frwh_4Y2Mj4ERoDp0ammsl4LYgjM3VJHBjITmADt8lg&usqp=CAU',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: AppColors.BLACK_500,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildPageImage() {
    final sizeImageUser = _viewModel!.carModel?.image?.length;
    return Hero(
      tag: '${_viewModel!.carModel?.name}',
      child: SizedBox(
        width: double.maxFinite,
        height: SpaceBox.sizeBig * 13,
        child: PageView.builder(
          itemCount: sizeImageUser,
          scrollDirection: Axis.horizontal,
          controller: _viewModel!.pageController,
          itemBuilder: (context, index) {
            return Transform(
              transform: Matrix4.identity()
                ..rotateX(_viewModel!.currentPageValue - index),
              child: buildImage(index),
            );
          },
        ),
      ),
    );
  }

  Widget buildListImage() {
    return Stack(
      children: [
        buildPageImage(),
        Positioned(
          bottom: SpaceBox.sizeMedium,
          left: SpaceBox.sizeBig*6,
          child: _viewModel!.setSmooth()
        )
      ],
    );
  }

  Widget buildNameCar() {
    final name= _viewModel!.carModel?.name;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Paragraph(
          content: name,
          style: STYLE_BIG.copyWith(
            color: AppColors.BLACK_500,
            fontWeight: FontWeight.bold,
          ),
        ),
         AnimatedBuilder(
          animation: _viewModel!.controller!,
          builder: (context, child) => GestureDetector(
            onTap: () => _viewModel!.isFavorite? _viewModel!.controller!.reverse()
              : _viewModel!.controller!.forward(),
            child: Icon(
              Icons.favorite, size: _viewModel!.sizeAnimation!.value,  
              color: _viewModel!.colorAnimation!.value,)
            ),
         ),
        // GestureDetector(onTap: () => _viewModel!.setFavorite(),
        //   child: _viewModel!.isFavorite
        //   ? const Icon(Icons.favorite, size: 30,  color: AppColors.PRIMARY_RED,)
        //   : const Icon(Icons.favorite_outline, size: 30,)),
      ],
    );
  }

  Widget buildPriceCar(){
    final price = _viewModel!.carModel?.price.toString();
    return Row(
      children: [
        Paragraph(
          content: 'Price:',
          style: STYLE_BIG.copyWith(
            color: AppColors.BLACK_500,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: SpaceBox.sizeSmall,),
        Paragraph(
          content: price,
          style: STYLE_MEDIUM.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.COLOR_MAROON
          ),
        ),
      ],
    );
  }

  Widget buildDescription() {
    final description = _viewModel!.carModel?.detail;
    return Padding(
      padding:  EdgeInsets.only(top: SizeToPadding.sizeVerySmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Paragraph(
            content:'Chi tiết xe: ',
            style: STYLE_LARGE.copyWith(
              color: AppColors.BLACK_500,
              fontWeight: FontWeight.w700,
            ),
          ),
          Paragraph(
            content: description ?? '',
            style: STYLE_MEDIUM.copyWith(
              color: AppColors.BLACK_500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SpaceBox.sizeSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNameCar(),
          buildPriceCar(),
          buildDescription()
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeMedium),
      child: AppButton(
        enableButton: true,
        content: 'Đặt Mua',
        onTap: () {
          _viewModel!.goToBookingCar();
        },
      ),
    );
  }

  Widget buildDetailCar() {
    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child:  Padding(
        padding: EdgeInsets.only(
          top: SizeToPadding.sizeMedium,
          left: SizeToPadding.sizeMedium,
          right: SizeToPadding.sizeMedium,
          bottom: BorderRadiusSize.sizeBig
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(),
              buildListImage(),
              buildInfo(),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
