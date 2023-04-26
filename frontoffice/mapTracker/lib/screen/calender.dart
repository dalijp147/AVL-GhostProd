import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.multiRange,
          showActionButtons: true,
          controller: _dateRangePickerController,
          onSubmit: (val) {
            print(val);
          },
          onCancel: _dateRangePickerController.selectedRanges = null,
        ),
      ),
    );
  }
}
