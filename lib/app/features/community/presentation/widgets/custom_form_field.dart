// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final String hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 30),
        TextFormField(
          inputFormatters: widget.inputFormatters,
          autofocus: true,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).hintColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            // remove max lines from hint
            hintStyle: const TextStyle(fontSize: 18, height: 1.2),
            hintMaxLines: 2,
          ),
          maxLength: widget.maxLength,
        ),
      ],
    );
  }
}
