import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({
    this.selectedDate,
    this.onDateChanged,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (_) => {},
            ),
          )
        : Row(
            children: [
              Expanded(
                child: Text(selectedDate == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
              ),
              TextButton(
                child: Text('Selecionar data'),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () => _showDatePicker(context),
              )
            ],
          );
  }
}