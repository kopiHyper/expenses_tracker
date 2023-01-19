import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions yet...',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * curScaleFactor,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14 * curScaleFactor,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
