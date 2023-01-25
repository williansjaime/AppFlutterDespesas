import 'dart:math';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';

void main() {
  runApp(Expenses());
}

class Expenses extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: expenses(),
    );
  }
}

class expenses extends StatefulWidget {
  @override
  State<expenses> createState() => _expensesState();
}

class _expensesState extends State<expenses> {
  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 211.30, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    var doubleValue = Random().nextDouble(); // Value is >= 0.0 and < 1.0.
    doubleValue = Random().nextDouble() * 256;
    final newTransaction = Transaction(
        id: doubleValue.toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Grafico'),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
