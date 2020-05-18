import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);
  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(
          Duration(days: index),
        );
        var totalSum = 0.0;
        for (var i = 0; i < _recentTransactions.length; i++) {
          if (_recentTransactions[i].dateTime.day == weekday.day &&
              _recentTransactions[i].dateTime.month == weekday.month &&
              _recentTransactions[i].dateTime.year == weekday.year) {
            totalSum += _recentTransactions[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
