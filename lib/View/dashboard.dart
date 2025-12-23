import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store_admin/View/update_products.dart';
import '../Controller/add_product_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Dashboard",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.products.isEmpty) {
              return Center(
                child: Text(
                  "No products Found",
                  style: TextStyle(color: Colors.black87),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchProduct();
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => UpdateProducts(product: controller.products[index]));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(controller.products[index].name ?? ""),
                          subtitle: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      controller.products[index].price.toString(),
                                ),
                                TextSpan(text: ' \$'),
                              ],
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              controller.deleteProduct(
                                controller.products[index].id ?? "",
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        );
      },
    );
  }
}