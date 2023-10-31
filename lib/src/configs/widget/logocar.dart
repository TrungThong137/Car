import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

class LogoCar extends StatelessWidget {
  const LogoCar({super.key, 
    required this.logoCar, 
    required this.nameCar, 
    this.onTap
  });
  final String logoCar;
  final String nameCar;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap!(),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Image.asset(
                logoCar,
                width: nameCar=='Jaguar'? 60 :  30,
              ),
            ),
          ),
    
          const SizedBox(height: 10,),
          Paragraph(content: nameCar, style: STYLE_SMALL_BOLD,)
        ],
      ),
    );
  }
}