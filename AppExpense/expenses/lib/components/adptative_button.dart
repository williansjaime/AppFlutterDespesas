import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const AdaptativeButton(
    this.label,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : ElevatedButton(
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
            onPressed: onPressed,
          );
  }
}



/*import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget{
  
  final String label;
  final Function() onPressd;

  AdaptiveButton({
    required this.label,
    required this.onPressd,
  });
  
  @override
  Widget build(BuildContext context){
    return
    Platform.isIOS?
    CupertinoButton(child: Text(label),onPressed: onPressd,
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(
      horizontal: 20
    ),
    )
    :
    TextButton(
      onPressed: onPressd,child: Text(label),);
     
  }
}*/