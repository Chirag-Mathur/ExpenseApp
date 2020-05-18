import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTransaction;

  TransactionList(this._userTransactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: _userTransactions.isEmpty
          ? Column(children: <Widget>[
              Text(
                'No Transactions',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ])
          : ListView.builder(
              itemBuilder: (cnt, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child:
                                Text('Rs.${_userTransactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(_userTransactions[index].dateTime),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTransaction(_userTransactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
