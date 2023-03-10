import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  late final closeModal = Navigator.of(context).pop();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    closeModal;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                cursorColor: Colors.purple,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                controller: _titleController,
                onSubmitted: (_) => {
                  _submitData,
                },
              ),
              TextField(
                cursorColor: Colors.purple,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => {
                  _submitData,
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 15 * curScaleFactor,
                        ),
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18 * curScaleFactor,
                            color: Colors.purple,
                          ),
                        ),
                        onPressed: () => closeModal),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                      ),
                      onPressed: _submitData,
                      child: Text(
                        'Add transaction',
                        style: TextStyle(
                          fontSize: 18 * curScaleFactor,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
