import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_space.dart';

class SmoothWidget extends StatelessWidget {
  const SmoothWidget({required this.controller, super.key, 
    this.count=1,});

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return count!=1? SmoothPageIndicator(
      controller: controller, 
      count: count ,
      effect: ExpandingDotsEffect(
        spacing: SpaceBox.sizeSmall,
        dotColor: AppColors.COLOR_WHITE,
        strokeWidth: 1,
        dotWidth: SpaceBox.sizeVerySmall,
        dotHeight: SpaceBox.sizeVerySmall,
        activeDotColor: AppColors.COLOR_WHITE,
      ),
      onDotClicked: (index) => controller.animateToPage(
        index, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.linear,
      ),
    ): Container();
  }
}