import 'dart:ui';

import 'package:flutter/material.dart';
import 'Signin.dart';

import 'Signup.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
                text: "Allocate",
                style: TextStyle(
                    color: Color.fromARGB(255, 30, 117, 141),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: " And",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  TextSpan(
                      text: " Sell",
                      style: TextStyle(
                          color: Color.fromARGB(255, 30, 117, 141),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " Anything",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  TextSpan(
                      text: "\n  Faster With GhostProd",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ]),
          ),
          Text("\n  Massive discounts and offerswhen you shop",
              style: TextStyle(color: Colors.black, fontSize: 10)),
          Padding(
              padding: const EdgeInsets.all(20),
              child: ButtonTheme(
                minWidth: size.width,
                height: 50,
                child: MaterialButton(
                  color: Color.fromARGB(255, 30, 117, 141),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signin()),
                    );
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 50,
                width: size.width,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 2, color: Color.fromARGB(255, 30, 117, 141))),
                  onPressed: () {
                    // Within the `FirstRoute` widget

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Color.fromARGB(255, 30, 117, 141)),
                  ),
                ),
              )),
          SizedBox(
            height: 50,
          )
        ],
      ),
    ));
  }
}
