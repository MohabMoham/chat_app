
import 'package:flutter/material.dart';
class CustomLoginButton extends StatelessWidget {
   CustomLoginButton({super.key, this.onTap,required this.buttonText});
  final String buttonText ;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,

        ),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Color(0xff2B475E),
              fontSize: 20
          ),
        ),
      ),
    );
  }
}
