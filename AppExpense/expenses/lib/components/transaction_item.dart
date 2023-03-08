import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color _backgroundColor =  Colors.green;
  
  @override
  void initState(){
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,                
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: FittedBox(
            child: Text('R\$${widget.tr.value}')
          ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
          ? TextButton.icon(
            onPressed: () => widget.onRemove(widget.tr.id), 
            icon: Icon(Icons.delete),
            label: Text("Excluir"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).errorColor, // This is a custom color variable
              ),                
          )
          :
          IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,
          onPressed: () => widget.onRemove(widget.tr.id),
          ),
        ),
    );
  }
}
