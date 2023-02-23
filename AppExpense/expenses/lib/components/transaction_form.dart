import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'adptative_button.dart';
import 'adaptative_textfield.dart';
import 'adaptative_date_picker.dart';


class TransactionForm extends StatefulWidget {
  final void Function(String, double,DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  var _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value,_selectedDate);
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
              AdaptativeDatePicker(
                selectedDate: _selectedDate, 
                onDatechanged: (newDate){
                  setState(() {
                    _selectedDate = newDate;
                  });
                }),
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
