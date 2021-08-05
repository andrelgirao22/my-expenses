import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chat extends StatelessWidget {
  final List<Transaction> recentsTransactions;

  Chat(this.recentsTransactions);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentsTransactions.length; i++) {
        bool sameDay = weekDay.day == recentsTransactions[i].date.day;
        bool sameMonth = weekDay.month == recentsTransactions[i].date.month;
        bool sameYear = weekDay.year == recentsTransactions[i].date.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentsTransactions[i].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'],
                  value: tr['value'],
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (tr['value'] as double) / _weekTotalValue,
                ),
              );
            }).toList()),
      ),
    );
  }
}
