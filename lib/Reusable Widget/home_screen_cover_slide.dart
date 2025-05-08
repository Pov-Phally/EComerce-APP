import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_dot_indicator/easy_dot_indicator.dart';
import 'package:flutter/material.dart';

class CSCoverSlider extends StatelessWidget {
  CSCoverSlider({super.key});
  final indicatorController = EasyDotIndicatorController();
  final int index = 0;
  final List<String> coverImages = [
    'https://img.freepik.com/free-vector/realistic-horizontal-sale-banner-template-with-photo_23-2149017940.jpg?semt=ais_hybrid',
    'https://img.freepik.com/free-vector/realistic-horizontal-sale-banner-template-with-photo_23-2149017940.jpg?semt=ais_hybrid',
    'https://img.freepik.com/free-vector/realistic-horizontal-sale-banner-template-with-photo_23-2149017940.jpg?semt=ais_hybrid',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.9,
              initialPage: index,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 900),
              enlargeCenterPage: true,
              enlargeFactor: 1,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, _) {
                indicatorController.updateIndex(index);
              },
            ),
            items: coverImages.map((e) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(e),
                    fit: BoxFit.fill,
                  ),
                ),
                width: MediaQuery.sizeOf(context).width,
              );
            }).toList(),
          ),
        ),
        EasyDotIndicator(
          dotConfig: EasyDotIndicatorCustomConfig(
            activeColor: Colors.purple,
            inactiveColor: Colors.grey,
          ),
          visibleNum: coverImages.length,
          count: coverImages.length,
          controller: indicatorController,
        ),
      ],
    );
  }
}