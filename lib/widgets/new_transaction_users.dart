import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionUser extends StatefulWidget {
  final Function addTx;
  NewTransactionUser(this.addTx);

  @override
  _NewTransactionUserState createState() => _NewTransactionUserState();
}

class _NewTransactionUserState extends State<NewTransactionUser> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selecteDate;

  void submittedData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selecteDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selecteDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2001),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selecteDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submittedData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submittedData(),
            ),
            Row(
              children: [
                Text(
                  _selecteDate == null
                      ? 'No Date Choosen Yet!!'
                      : 'Picked Date ${DateFormat.yMd().format(_selecteDate)}',
                ),
                SizedBox(
                  width: 28.0,
                ),
                Expanded(
                  child: FlatButton(
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date')),
                ),
              ],
            ),
            RaisedButton(
              onPressed: submittedData,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Add Transaction',
              ),
            )
          ],
        ),
      ),
    );
  }
}
