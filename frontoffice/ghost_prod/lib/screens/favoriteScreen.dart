import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/product_provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context).itemfs;
    final providers = Provider.of<Products>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 110,
                      width: 200,
                      child: Text("the Favorites",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 34, 40, 49),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                height: 472,
                width: 1000,
                child: ListView.builder(
                  itemCount: provider.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 80.0,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.asset(
                                  provider[index].imageUrl!,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                                height: 10,
                              ),
                              Container(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider[index].name!,
                                        style: TextStyle(color: Colors.white)),
                                    Text(provider[index].price.toString())
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  providers.toggle(provider[index]);
                                },
                                icon: Icon(providers.isExist(provider[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                color: Color.fromARGB(255, 226, 163, 60),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
