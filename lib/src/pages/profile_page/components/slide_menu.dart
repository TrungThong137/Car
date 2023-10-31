import 'package:flutter/material.dart';

class SlideMenuTitle extends StatelessWidget {
  const SlideMenuTitle({super.key, 
    this.ontap, 
    this.text, 
    required this.index, 
    this.icon, 
    required this.selectedIndex
  });
  final Function? ontap;
  final String? text;
  final int selectedIndex;
  final int index;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap!();
      },
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            height: 56,
            width: selectedIndex==index ? MediaQuery.of(context).size.width : 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF6792FF),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            )
          ),
          ListTile(
            leading: SizedBox(
              height: 34,
              width: 34,
              child: Icon(icon, color: Colors.black,),
            ),
            title: Text(
              text??"",
            style: const TextStyle(color: Colors.black),
            )
          ),
        ]
      ),
    );
  }
}