import 'package:flutter/material.dart';
import 'package:task_list/src/theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const CustomTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(
              top: 8.0,
            ),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    controller: controller,
                    style: subtTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subtTitleStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
