import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SmsFiller extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PinFieldAutoFill(
          codeLength: 4,
          autoFocus: true,
          decoration: UnderlineDecoration(
            lineHeight: 2,
            lineStrokeCap: StrokeCap.square,
            bgColorBuilder: PinListenColorBuilder(
                Colors.green.shade200, Colors.grey.shade200),
            colorBuilder: const FixedColorBuilder(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
