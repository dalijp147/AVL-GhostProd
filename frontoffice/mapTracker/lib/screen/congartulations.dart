import 'package:flutter/material.dart';
import 'detailScreen.dart';
import 'profile.dart';
import '../models/size.dart';

class last extends StatefulWidget {
  const last({Key? key}) : super(key: key);

  @override
  State<last> createState() => _lastState();
}

class _lastState extends State<last> {
  bool _value = false;
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Image(image: AssetImage("assets/images/congra.png")),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Congratulations !!!\n",
                style: TextStyle(
                    fontSize:
                        getResponsiveItemSize(width: size.width, value: 20),
                    fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                    text: "Your order have been taken \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getResponsiveItemSize(
                            width: size.width, value: 11)),
                    children: [
                      TextSpan(
                          text: "and is beeing attended too",
                          style: TextStyle(
                              fontSize: getResponsiveItemSize(
                                  width: size.width, value: 11),
                              color: Colors.black))
                    ]),
              ),
              SizedBox(
                height: size.height * 0.04,
                width: getResponsiveItemSize(width: size.width, value: 20),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Detail()),
                  );
                },
                child:
                    Text("Track Order", style: TextStyle(color: Colors.white)),
                color: Colors.indigo,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2, color: Colors.indigo)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const profile()),
                  );
                },
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
