import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              //onChanged: (newValue) => title = newValue,
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              //onChanged: (newValue) => valor = newValue,
              controller: valueController,
              decoration: InputDecoration(
                labelText: 'Valor R\$',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    print(titleController.text);
                    print(valueController.text);
                  },
                  child: Text(
                    "Nova transação",
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.purple, // Text Color
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
