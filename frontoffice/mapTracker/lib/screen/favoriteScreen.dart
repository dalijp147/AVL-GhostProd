import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:map/Models/dbfavorite.dart';
import 'package:map/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../Models/product.dart';
import '../provider/product_provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    context.read<Favoriteprovider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    DBFavorite? dbFavorite = DBFavorite();
    final fav = Provider.of<Favoriteprovider>(context);
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
                  itemCount: fav.fav.length,
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
                              Image.network(
                                fav.fav[index].imageUrl!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
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
                                    Text(fav.fav[index].name!,
                                        style: TextStyle(color: Colors.white)),
                                    Text('${fav.fav[index].price} DT')
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  dbFavorite!.deleteItem(fav.fav[index].id);
                                  fav.removeItem(fav.fav[index].id);
                                },
                                icon: Icon(
                                  Iconsax.trash,
                                ),
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
