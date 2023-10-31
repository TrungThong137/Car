import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, 
    required this.textLeft, 
    required this.textRight, 
    required this.onTap
  });
  final String textLeft;
  final String textRight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Paragraph(content: textLeft, style: STYLE_LARGE_BOLD,),
        InkWell(
          onTap: onTap,
          child: Paragraph(content: textRight, fontWeight: FontWeight.bold,))
      ],
    );
  }
}