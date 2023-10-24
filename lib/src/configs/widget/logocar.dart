import 'package:car_app/src/configs/widget/text_small.dart';
import 'package:flutter/material.dart';

class LogoCar extends StatelessWidget {
  const LogoCar({super.key, 
    required this.logoCar, 
    required this.nameCar
  });
  final String logoCar;
  final String nameCar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
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
          TextSmall(text: nameCar, fontWeight: FontWeight.bold,)
        ],
      ),
    );
  }
}