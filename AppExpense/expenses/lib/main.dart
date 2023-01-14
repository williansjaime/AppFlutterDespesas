import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

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

class expenses extends StatelessWidget {
  final _transactions = [
    Transation(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transation(
        id: 't2', title: 'Conta de Luz', value: 211.30, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Grafico'),
                elevation: 5,
              )),
          Card(
            child: Text('Lista de Transações'),
          ),
        ],
      ),
    );
  }
}
