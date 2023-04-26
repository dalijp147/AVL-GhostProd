import 'package:flutter/material.dart';
import 'package:ghost_prod/screens/paymentScreen.dart';
import 'package:http/http.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 5,
          top: 10,
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
                    Text('Delivery address',
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
                      child: GestureDetector(
                        onTap: () {
                       
                        },
                        child: TextFormField(
                            decoration: InputDecoration(
                          border: InputBorder.none,
                        )),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Number we can call',
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
                )
              ],
            )),
            SizedBox(
              height: 100,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Pay on delivery',
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
                OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(25),
                            topStart: Radius.circular(25),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext cc) {
                          return PaymentScreen();
                        });
                  },
                  child: Text(
                    'Pay with card',
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
