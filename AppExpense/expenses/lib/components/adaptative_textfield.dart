import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptativeTextFild extends  StatelessWidget{

  final String label;  
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;
  
  AdaptativeTextFild(
  {
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context)
  {
    return Platform.isIOS?
    CupertinoTextField(
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      placeholder: label,
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 12,
      ),

    )
    :
    TextField(
      //onChanged: (newValue) => valor = newValue,
      controller: controller,
      keyboardType: keyboardType,//TextInputType.numberWithOptions(decimal: true),
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
} 