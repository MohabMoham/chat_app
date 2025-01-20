import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,required this.hintText,this.onChanged,this.obscureText = false});
final String hintText ;
bool obscureText ;
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data)
      {
        if(data!.isEmpty)
          {
            return 'field is required';
          }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,

          hintStyle: TextStyle(
              color: Colors.white
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(
                color: Colors.white
            ),
          )

      ),
    );
  }
}


