import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    super.key, 
    this.content,
    this.isChecked=false, 
    required this.onTap
  });

  final String? content;
  final bool isChecked;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.BLACK_500,
                width: 2.5,
              ),
            ),
            child: Icon(
              Icons.check,
              size: 15,
              weight: 2,
              color: isChecked ? AppColors.BLACK_500 : Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          Paragraph(
            content: content,
           style: STYLE_MEDIUM_BOLD,
          ),
        ],
      ),
    );
  }
}
