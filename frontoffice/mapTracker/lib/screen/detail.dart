import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/product.dart';

class Det extends StatelessWidget {
  var urlImage = [
    'https://www.usaoncanvas.com/images/low_res_image.jpg',
    'https://www.usaoncanvas.com/images/low_res_image.jpg',
    'https://www.usaoncanvas.com/images/low_res_image.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider.builder(
            itemCount: urlImage.length,
            itemBuilder: (context, index, realIndex) {
              final urlmage = urlImage[index];
              return buildImage(urlmage, index);
            },
            options: CarouselOptions(height: 200, enlargeCenterPage: true)),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
