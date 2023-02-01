import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;

  TransactionList(this.transaction,this.onRemove); //contrutor
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: transaction.isEmpty ? 
      Column(
        children: <Widget>[
        SizedBox(height: 20,),  
        Text('Nenhum Transação Cadastrar!',
        style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 20,),
        Container(
          height:200,
          child:Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),),],
      ) 
      
      :ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx, index) {
          final tr = transaction[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,                
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('R\$${tr.value}')
                  ),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(tr.date),
                ),
                trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,
                onPressed: () => onRemove(tr.id),
                ),
                ),
            );
            
        },
      ),
    );
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