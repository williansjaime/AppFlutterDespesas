import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;

  TransactionList(this.transaction,this.onRemove); //contrutor
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty ? 

    LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
          SizedBox(height: constraints.maxHeight * 0.05,),  
          Container(
            height: constraints.maxHeight * 0.3,
            child: Text('Nenhum Transação Cadastrar!',
            style: Theme.of(context).textTheme.titleLarge,),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height:constraints.maxHeight * 0.6,
            child:Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),),],
        );
      }
    ) 
    :ListView(
      children: transaction.map((tr) {
      return TransactionItem(
        key: ValueKey(tr.id),
        tr: tr, 
        onRemove: onRemove
        );
    }).toList()
    );
    // :ListView.builder(
    //   itemCount: transaction.length,
    //   itemBuilder: (ctx, index) {
    //     final tr = transaction[index];
    //       return TransactionItem(tr: tr, onRemove: onRemove);
          
    //   },
    // );
  }
}



/*
//Return Antigo caso precisar

Card(
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )),
                padding: EdgeInsets.all(10),
                child: Text(
                  'R\$ ${tr.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ]),
          );
          */