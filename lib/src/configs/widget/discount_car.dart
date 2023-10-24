

import 'package:car_app/src/configs/widget/text_largest.dart';
import 'package:flutter/material.dart';

class DiscountCar extends StatefulWidget {
  const DiscountCar({super.key, 
    this.discount='', 
    required this.imageCar,
    this.isText=true, 
    this.width=double.maxFinite, 
    this.height=180, 
    this.widthCar=180,  
    this.positionTop=40, 
    this.isImageNetWord=false,
  });
  final String discount;
  final String imageCar;
  final bool isText;
  final double width;
  final double height;
  final double widthCar;
  final double positionTop;
  final bool isImageNetWord;

  @override
  State<DiscountCar> createState() => _DiscountCarState();
}

class _DiscountCarState extends State<DiscountCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Stack(
        children: [
          widget.isText? Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLargest(text: widget.discount, fontSize: 35.0,),
                const SizedBox(height: 10,),
                const TextLargest(text: 'Week Deals!'),
                const SizedBox(height: 10,),
                const SizedBox(
                  width: 170,
                  child: Text(
                    'Get a new car discount, only valid week'
                  )
                )
              ],
            ),
          ): Container(),
          Positioned(
            top: widget.positionTop,
            right: 10,
            child: !widget.isImageNetWord ? Image.asset(
              widget.imageCar,
              width: widget.widthCar,
            ): Image.network(widget.imageCar, width: widget.widthCar,),
          ),
        ],
      ),
    );
  }
}