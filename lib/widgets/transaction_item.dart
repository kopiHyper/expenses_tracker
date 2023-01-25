import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.curScaleFactor,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final double curScaleFactor;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            '\$${transaction.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.purple,
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18 * curScaleFactor,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 14 * curScaleFactor,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                ),
                label: const Text('Delete'),
                onPressed: () => deleteTx(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
