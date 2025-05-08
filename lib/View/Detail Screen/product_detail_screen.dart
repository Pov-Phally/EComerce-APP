import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Controller/Product%20Detail/product_detail_controller.dart';
import 'package:kh_online_store/Model/product_model.dart';
import 'package:kh_online_store/Reusable%20Widget/alert_message.dart';
import 'package:readmore/readmore.dart';

import '../../Controller/Cart/cart_controller.dart';
import '../../Reusable Widget/cs_appbar.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productDetailController = Get.put(ProductDetailController());
  final cartController = Get.find<CartController>();

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(0),
          color: Colors.grey.shade300,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      //Image product
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        height: 350,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.product.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: widget.product.images[index],
                            );
                          },
                        ),
                      ),
                      // Image product scrollable
                      Positioned(
                        right: 0,
                        bottom: 20,
                        left: 24,
                        child: SizedBox(
                          height: 80,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            separatorBuilder: (_, __) => SizedBox(width: 24),
                            itemCount: widget.product.images.length,
                            itemBuilder:
                                (_, index) =>
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(index);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color:
                                        _currentIndex == index
                                            ? Colors.deepPurpleAccent
                                            : Colors.grey,
                                      ),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          widget.product.images[index],
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      //App Bar
                      CSAppBar(),
                    ],
                  ),
                ],
              ),
              //Second container
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(
                  top: MediaQuery
                      .sizeOf(context)
                      .height * 0.41,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Product name
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    //Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.product.price.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share_outlined),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    //Colors
                    Text(
                      'Colors',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Select Colors
                    Obx(() {
                      return Wrap(
                        spacing: 10,
                        children:
                        widget.product.colors.map((colors) {
                          return ChoiceChip(
                            label: Text(colors),
                            selected: productDetailController.selectedColor
                                .value == colors,
                            onSelected: (selected) {
                              productDetailController.selectedColor.value =
                              (selected ? colors : colors);
                            },
                            checkmarkColor: Colors.black87,
                            side: BorderSide(
                              color:
                              productDetailController.selectedColor.value ==
                                  colors
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              width: productDetailController.selectedColor
                                  .value == colors ? 2.5 : 1,
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    //Size
                    Text(
                      'Size',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Select sizes
                    Obx(() {
                      return Wrap(
                        spacing: 10,
                        children:
                        widget.product.sizes.map((sizes) {
                          return ChoiceChip(
                            label: Text(sizes),
                            selected: productDetailController.selectedSize
                                .value == sizes,
                            onSelected: (selected) {
                              productDetailController.selectedSize.value =
                                  selected ? sizes : sizes;
                            },
                            checkmarkColor: Colors.black87,
                            side: BorderSide(
                              color:
                              productDetailController.selectedSize.value ==
                                  sizes
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              width: productDetailController.selectedSize
                                  .value == sizes ? 2.5 : 1,
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    SizedBox(height: 10),
                    //Description
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ReadMoreText(
                      widget.product.description,
                      trimLines: 4,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' \nShow less',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //Bottom nav
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        //Add to cart
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              spacing: 20,
              children: [
                IconButton(
                  onPressed: productDetailController.decrementQuantity,
                  icon: Icon(Icons.remove),
                  color: Colors.black87,
                ),
                Obx(() {
                  return Text(
                    '${productDetailController.quantity}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }),
                IconButton(
                  onPressed: productDetailController.incrementQuantity,
                  icon: Icon(Icons.add),
                  color: Colors.black87,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (productDetailController.selectedSize.value.isNotEmpty &&
                    productDetailController.selectedSize.value.isNotEmpty) {
                  cartController.addToCart(
                    widget.product,
                    productDetailController.selectedColor.value,
                    productDetailController.selectedSize.value,
                    productDetailController.quantity.value,
                  );
                  alert(context, 'Product added to cart');
                } else {
                  alert(context, 'Please select a color and size');
                }
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}