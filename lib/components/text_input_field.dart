import '../components/size_fade_switcher.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final void Function(String value) onChanged;
  final bool isObsecured;
  TextInputField({
    Key? key,
    this.hintText,
    required this.onChanged,
    this.isObsecured = false,
    this.errorText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD0D0F0),
              width: 1.5
            )
          ),
          child: TextField(
            style:  TextStyle(
              color: Theme.of(context).accentColor
            ),
            obscureText: isObsecured,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFFC2C2C2)
              )
            ),
          ),
        ),
         SizeFadeSwitcher(
            child: errorText != null?
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child:  Text(
                errorText!,
                style: TextStyle(
                    color: Theme.of(context).errorColor
                ),
              ),
            ):const SizedBox.shrink()
        ),
      ],
    );
  }
}
