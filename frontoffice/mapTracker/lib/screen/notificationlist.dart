import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../screen/notification.dart';

import '../Models/notif.dart';
import '../Service/api_service.dart';

class NotificationList extends StatelessWidget {
  List<Notificationf> notif = List<Notificationf>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
      ),
      body: loadProduct(),
    );
  }

  // ignore: avoid_types_as_parameter_names
  Widget productList(notif) {
    return Container(
      height: 200,
      width: 500,
      child: ListView.builder(
          itemCount: notif.length,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, int i) {
            return NotificationScreen(model: notif[i]);
          }),
      // GridView.builder(
      //   padding: const EdgeInsets.all(8.0),
      //   itemCount: notif.length,
      //   itemBuilder: (ctx, i) {
      //     return GestureDetector(
      //         onTap: () {}, child: NotificationScreen(model: notif[i]));
      //   },
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 12.2,
      //       mainAxisSpacing: 12.2,
      //       mainAxisExtent: 250),
      // ),
    );
  }

  Widget loadProduct() {
    return FutureBuilder(
        future: APIService.getnotification(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Notificationf>?> model) {
          if (model.hasData) {
            return productList(model.data);
          } else if (model.hasError) {
            return Text('${model.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
