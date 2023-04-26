import 'package:flutter/material.dart';
import 'package:ghost_prod/screens/productScreen.dart';

class DetailComScreen extends StatelessWidget {
  const DetailComScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 4, 86, 100),
        toolbarHeight: 100,
        title: Text('votre commande que vous a été livrez'),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(children: [
            Text("DETAIL DE VOTRE COMMANDE"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1x camera",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("9.000 DT"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1x camera",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("9.000 DT"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1x camera",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("9.000 DT"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1x camera",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("9.000 DT"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("9.000 DT"),
              ],
            ),
            Text("ADRESSE DE LIVRAISON"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [Text('soussa '), Text("sahloul")],
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductScreen()));
              },
              child: Text('COMMANDER A NOUVEAU'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 4, 86, 100),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
