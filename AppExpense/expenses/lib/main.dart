import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';
import 'components/chart.dart';


void main() {
  runApp(Expenses());
}

class Expenses extends StatelessWidget {
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          ),
          /*button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )*/
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
  final List<Transaction> _transactions = [];
  bool _showChart = false;


    List<Transaction> get _recentTransactions {
      return _transactions.where((tr)
      {
        return tr.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
        ));
      }).toList();
    }

  _addTransaction(String title, double value,DateTime date) {
    var doubleValue = Random().nextDouble(); // Value is >= 0.0 and < 1.0.
    doubleValue = Random().nextDouble() * 256;
    final newTransaction = Transaction(
        id: doubleValue.toString(),
        title: title,
        value: value,
        date: date,
        );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) 
  {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final charList = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;
    
    final action = <Widget>[
          if(isLandscape)
            _getIconButton(_showChart? iconList : charList,
              (){
                setState(() {
                  _showChart = !_showChart;
                });
              },
              
            ),
          _getIconButton(
            Platform.isIOS? CupertinoIcons.add:Icons.add,
            () => _openTransactionFormModal(context),
            )
        ];
      final PreferredSizeWidget appbar = Platform.isIOS 
      ? CupertinoNavigationBar(
          middle: Text("Despesas pessoais"),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: action,
            ),
        ) as PreferredSizeWidget
        : AppBar(
          title: Text('Despesas Pessoais',
          style: TextStyle(fontFamily: 'OpenSans',),
          ),
          actions: action,
        ) as PreferredSizeWidget;

    final avalableHeight = mediaQuery.size.height 
    - appbar.preferredSize.height - 
     mediaQuery.padding.top;

    final bodypage = SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              // if(isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text("Exibir Grafico"),
              //       Switch.adaptive(
              //         activeColor: Theme.of(context).accentColor,
              //         value: _showChart, onChanged: ((value) {
              //         setState(() {
              //           _showChart = value;
              //         });
              //       }))
              //     ],
              //   ),
              if(_showChart || !isLandscape)
                Container(
                  height: avalableHeight * (isLandscape? 0.7 : 0.30),
                  child: Chart(_recentTransactions)),
              if(!_showChart || !isLandscape)    
                Container(
                  height: avalableHeight * (isLandscape? 1 : 0.70),
                  child: TransactionList(_transactions, _removeTransaction)),
          ],
        ),
      );

    return Platform.isIOS ? 
    CupertinoPageScaffold(
      navigationBar: AppBar as ObstructingPreferredSizeWidget,
      child: bodypage,)
    : 
    
    Scaffold(
      appBar: appbar,
      body: bodypage,
      floatingActionButton: //Platform.isIOS ? 
       //Container():
       FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
