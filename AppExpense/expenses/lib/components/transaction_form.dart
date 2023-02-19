import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'adptative_button.dart';
import 'adaptative_textfield.dart';


class TransactionForm extends StatefulWidget {
  final void Function(String, double,DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  var selectedData = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || selectedData == null) {
      return;
    }
    widget.onSubmit(title, value,selectedData);
  }

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
      ).then((picedDate) {
        if(picedDate == null){
          return;
        }
       
       setState(() {
         selectedData = picedDate; 
       });
       
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left:10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,         
            ),
          child: Column(
            children: <Widget>[
              AdaptativeTextFild(
                label:"Titulo", 
                controller: _titleController, 
                onSubmitted: (_) => _submitForm(),
                
              ),
              AdaptativeTextFild(
                label: 'Valor R\$',
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      selectedData == null ?'Nenhuma data seleciondada!'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedData)}')),
    
                  TextButton(
                    onPressed: _showDatePicker, 
                    child: Text(
                      'Selecionar Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                   AdaptativeButton(
                    'Nova Transação',
                    _submitForm,
                  ),
                  //AdaptiveButton(label: "Nova transação", onPressd: _submitForm())
                  /*TextButton(
                    onPressed: () {
                      _submitForm();
                      /*{
                      final title = _titleController.text;
                      final value = double.tryParse(_valueController.text) ?? 0.0;
                      widget.onSubmit(title, value);*/
                    },
    
                    child: Text(
                      "Nova transação",
                    ),
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor, // Text Color
                    ),                    
                  ),*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
