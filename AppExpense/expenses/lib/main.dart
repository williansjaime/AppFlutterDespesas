import 'dart:math';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';
import 'components/chart.dart';
void main() {
  runApp(Expenses());
}

class Expenses extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: expenses(),
      theme: ThemeData(primarySwatch: Colors.green,
      accentColor: Colors.amber,
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge:TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        )
      )
      ),
      
    );
  }
}

class expenses extends StatefulWidget {
  @override
  State<expenses> createState() => _expensesState();
}

class _expensesState extends State<expenses> {
  final List<Transaction> _transactions = [
    Transaction(id: 't0', title: 'Conta Antiga', value: 310.76, date: DateTime.now().subtract(Duration(days: 3))
    ),
    Transaction(id: 't1', title: 'Novo Tenis de corrida', value: 400.00, date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(id: 't2', title: 'Conta de LUZ', value: 400.00, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't4', title: 'jogo', value: 400.00, date: DateTime.now().subtract(Duration(days: 4))),
    ];

    List<Transaction> get _recentTransactions {
      return _transactions.where((tr)
      {
        return tr.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
        ));
      }).toList();
    }

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

    Navigator.of(context).pop();
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
        title: Text('Despesas Pessoais',
        style: TextStyle(fontFamily: 'OpenSans',),),
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
              Chart(_recentTransactions),
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
