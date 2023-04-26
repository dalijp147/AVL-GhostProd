import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghost_prod/screens/detailcommende.dart';
import 'package:ghost_prod/widget/transparent_image_card.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context).itemfs;
    final providers = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Order History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailComScreen()));
            },
            child: ListView.builder(
                itemCount: provider.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                          height: 70,
                          width: 70,
                          provider[index].imageUrl!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [Text("data"), Text("livré"), Text('date')],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.navigate_next_outlined)),
                      )
                    ]),
                  );
                }),
          ))
        ],
      )),
    );
  }
}
