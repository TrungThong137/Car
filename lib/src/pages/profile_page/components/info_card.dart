import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, 
    required this.profession,
  });

  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: AppColors.BLACK_500,
        child: Icon(Icons.person_outline, color: Colors.white,),
      ),
      title: Paragraph(
        content: name,
        style: STYLE_LARGE.copyWith(
          fontWeight: FontWeight.w600,
        )
      ),

      subtitle: Paragraph(
        content: profession,
        style: STYLE_SMALL_BOLD.copyWith(color: AppColors.BLACK_500)
      ),
    );
  }
}