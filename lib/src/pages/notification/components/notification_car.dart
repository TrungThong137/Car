import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:car_app/src/models/car_notification.dart';
import 'package:flutter/material.dart';

class NotificationCarWidget extends StatelessWidget {
  const NotificationCarWidget({super.key, 
    required this.car, 
    required this.context
  });

  final CarNotification car;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeToPadding.sizeSmall,
        horizontal: SizeToPadding.sizeMedium
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvatar(),
          SizedBox(width: SpaceBox.sizeMedium,),
          buildInfoNotification(),
        ],
      ),
    );
  }

  Widget buildTitle(){
    return Paragraph(
      content: 'Đơn hàng đã được đặt',
      style: STYLE_MEDIUM.copyWith(
        fontWeight: FontWeight.w600
      ),
    );
  }

  Widget buildContent(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width-110,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: AppColors.BLACK_500),
          children: [
            const TextSpan(
              text: 'Đơn hàng xe ',
              style: STYLE_MEDIUM
            ),
            TextSpan(
              text: car.name,
              style: STYLE_MEDIUM.copyWith(
                fontWeight: FontWeight.w600,
              )
            ),
            car.status!.contains('add')? const TextSpan(
              text: ' của bạn đã đặt thành công. Cảm ơn đã mua sắm cùng ',
              style: STYLE_MEDIUM
            ): const TextSpan(
              text: ' của bạn đã được hủy. Cảm ơn đã mua sắm cùng ',
              style: STYLE_MEDIUM
            ),
            TextSpan(
              text: 'AutoTECH',
              style: STYLE_MEDIUM.copyWith(
                fontWeight: FontWeight.w600,
              )
            ),
          ]
        ),
      ),
    );
  }

  Widget buildImage(){
    return Padding(
      padding: EdgeInsets.only(top: SpaceBox.sizeVerySmall),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(BorderRadiusSize.sizeMedium)),
        child: Image.network(
          car.image?[0] ??
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmVfPm6hKZTky6SpTNvEZqaqa8frwh_4Y2Mj4ERoDp0ammsl4LYgjM3VJHBjITmADt8lg&usqp=CAU',
          fit: BoxFit.cover,
          width: 100,
          height: 50,
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

  Widget buildInfoNotification(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(),
        buildContent(),
        buildImage(),
      ],
    );
  }

  Widget buildAvatar(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.BLACK_500),
        borderRadius: BorderRadius.circular(SpaceBox.sizeBig)
      ),
      child: CircleAvatar(
        foregroundColor: AppColors.BLACK_500,
        maxRadius: SpaceBox.sizeBig,
        backgroundColor: AppColors.COLOR_WHITE,
        child: const Icon(Icons.shopify_rounded, size: 32,),
      ),
    );
  }
}