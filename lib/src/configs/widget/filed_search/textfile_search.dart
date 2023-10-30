import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({super.key, 
    required this.onChange, 
  });
  final Function? onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value){
        onChange!(value);
      },
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.12),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.12))
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none
        ),
        // ignore: deprecated_member_use
        prefixIcon: SvgPicture.asset('assets/search.svg', fit: BoxFit.scaleDown, color: Colors.grey.withOpacity(0.8), width: 60,),
        // ignore: deprecated_member_use
        suffixIcon: SvgPicture.asset('assets/Filter.svg', fit: BoxFit.scaleDown, color: Colors.black, width: 60,),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.7)
        )
      ),
    );
  }
}