import 'package:flutter/material.dart';
import '../screen/calender.dart';
import '../screen/calender2.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 5,
          top: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Card Holders Name',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Card Number',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 175,
                    ),
                    Text("CCV", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 134,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 241, 241),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                            border: InputBorder.none,
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 134,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 241, 241),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                            border: InputBorder.none,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CAlenderSc()));
                  },
                  child: Text(
                    'Complete Order',
                    style: TextStyle(
                        color: Color.fromARGB(255, 39, 152, 183),
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(137, 56),
                    side: BorderSide(
                      color: Color.fromARGB(255, 39, 152, 183),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
