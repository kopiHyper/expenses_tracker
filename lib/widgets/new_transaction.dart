import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  late final closeModal = Navigator.of(context).pop();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    closeModal;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                labelText: 'Tytuł',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
              ),
              controller: titleController,
              onSubmitted: (_) => {
                submitData,
              },
            ),
            TextField(
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                labelText: 'Kwota',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
              ),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => {
                submitData,
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                      onPressed: () => closeModal),
                  ElevatedButton(
                    child: Text(
                      'Add transaction',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: submitData,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
