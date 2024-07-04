import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pletform_converter_app/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class AddContactProvider extends ChangeNotifier {
  String date = "";
  String time = "";
  DateTime cupertinoTime = DateTime.now();
  DateTime cupertinoDate = DateTime.now();
  String newCupertinoDate = "";
  String newCupertinoTime = "";

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1965),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formatedDate = DateFormat("dd/MM/yyyy").format(pickDate);
      date = formatedDate;
    }
    notifyListeners();
  }

  showMaterialTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      TimeOfDay formattedTime =
          TimeOfDay(hour: newTime.hour, minute: newTime.minute);
      time = formattedTime.format(context);
    }
    notifyListeners();
  }

  void showCupertinoTime(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          color: (Provider.of<SettingProvider>(context).isDark)
              ? Colors.black
              : Colors.white,
          child: CupertinoDatePicker(
            initialDateTime: cupertinoTime,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            onDateTimeChanged: (value) {
              cupertinoTime = value;
              newCupertinoTime =
                  "${cupertinoTime.hour} : ${cupertinoTime.minute}";
              notifyListeners();
            },
          ),
        );
      },
    );
  }

  void showCupertinoDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          color: (Provider.of<SettingProvider>(context).isDark)
              ? Colors.black
              : Colors.white,
          child: CupertinoDatePicker(
            initialDateTime: cupertinoDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              cupertinoDate = value;
              newCupertinoDate =
                  "${cupertinoDate.day} - ${cupertinoDate.month} - ${cupertinoDate.year}";
              notifyListeners();
            },
          ),
        );
      },
    );
  }

  clearDateTimeData() {
    newCupertinoDate = "";
    newCupertinoTime = "";
    notifyListeners();
  }

  hotReload() {
    notifyListeners();
  }
}
