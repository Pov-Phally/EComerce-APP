import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store_admin/Model/product_model.dart';
import '../Controller/add_product_controller.dart';
import '../utils/Dropdown button/cs_dropdown_button.dart';
import '../utils/Elevated Button/cs_elevated_button.dart';
import '../utils/TextFormField/cs_text_form_field.dart';
import 'add_category.dart';

class UpdateProducts extends StatefulWidget {
  final Product product;
  const UpdateProducts({super.key, required this.product});

  @override
  State<UpdateProducts> createState() => _UpdateProductsState();
}

class _UpdateProductsState extends State<UpdateProducts> {
  final controller = Get.find<AddProductController>();

  @override
  void initState() {
    super.initState();
    controller.setDataForUpdate(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Products"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              //Product name
              CSTextFormField(
                label: 'Product Name',
                hintText: 'Enter your product name',
                controller: controller.productNameController,
                maxLine: 1,
              ),
              SizedBox(height: 20),
              //Product ID
              CSTextFormField(
                label: 'Product ID',
                hintText: 'Enter your product ID',
                controller: controller.productIdController,
                maxLine: 1,
                readOnly: true,
              ),
              SizedBox(height: 20),
              //Product description
              CSTextFormField(
                label: 'Product Description',
                hintText: 'Enter your product Description',
                controller: controller.productDescriptionController,
              ),
              SizedBox(height: 20),
              //Product price
              CSTextFormField(
                label: 'Product Price',
                hintText: 'Enter your product Price',
                controller: controller.productPriceController,
                maxLine: 1,
              ),
              SizedBox(height: 20),
              // Product colors
              CSTextFormField(
                label: 'Add Color',
                hintText: 'Add Color',
                controller: controller.colorController,
                maxLine: 1,
                onFieldSubmitted: (value) {
                  controller.addColor(value);
                  controller.colorController.clear();
                },
              ),
              Obx(
                    () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.selectedColors.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.selectedColors[index]),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            controller.removeColor(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Product sizes
              CSTextFormField(
                label: 'Add Size',
                hintText: 'Add Size',
                controller: controller.sizeController,
                maxLine: 1,
                onFieldSubmitted: (value) {
                  controller.addSize(value);
                  controller.sizeController.clear();
                },
              ),
              Obx(
                    () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.selectedSizes.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.selectedSizes[index]),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            controller.removeSize(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Thumbnail image
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.pickThumbnail();
                        },
                        child: Text('Choose Thumbnail Image'),
                      ),
                      Obx(
                            () =>
                        controller.isLoading.value
                            ? Center(
                          child: CircularProgressIndicator(
                            padding: EdgeInsets.all(10),
                          ),
                        )
                            : controller.thumbnailUrl.value.isNotEmpty
                            ? Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Image.network(
                                    controller.thumbnailUrl.value,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, size: 20),
                                  onPressed: () {
                                    controller.removeThumbnail();
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Product image
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.pickImages();
                        },
                        child: Text('Choose Product Image'),
                      ),
                      Obx(
                            () => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          shrinkWrap: true,
                          itemCount: controller.imageUrls.length + controller.selectedImageNames.length,
                          itemBuilder: (context, index) {
                             if (index < controller.imageUrls.length) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Flexible(child: Text(controller.imageUrls[index].split('/').last.split('?').first, overflow: TextOverflow.ellipsis)),
                                     IconButton(
                                      icon: Icon(Icons.close, size: 20),
                                      onPressed: () {
                                        controller.imageUrls.removeAt(index);
                                      },
                                    ),
                                  ],
                                );
                            } else {
                                int newIndex = index - controller.imageUrls.length;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.selectedImageNames[newIndex]),
                                    IconButton(
                                      icon: Icon(Icons.close, size: 20),
                                      onPressed: () {
                                        controller.removeSelectedImage(newIndex);
                                      },
                                    ),
                                  ],
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Choose category
                  Flexible(
                    child: Obx(() {
                      return CSDropdownBTB(
                        items:
                        controller.categories
                            .map((category) => category.name)
                            .toList(),
                        selectItemText:
                        controller.category.isEmpty
                            ? 'Select a category'
                            : controller.category.value,
                        onSelected: (selectValue) {
                          controller.category.value = selectValue ?? '';
                        },
                      );
                    }),
                  ),
                  SizedBox(width: 10),
                  // Add category
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Set the desired border radius here
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => AddCategory());
                        },
                        child: Text(
                          'Add Category',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Feature product
              Obx(
                    () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Feature Product',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  value: controller.isFeatured.value,
                  onChanged: (value) {
                    controller.isFeatured.value = value ?? false;
                  },
                ),
              ),
              SizedBox(height: 10),
              //Update product
              CSElevatedButton(
                text: 'Update Product',
                onPressed: () {
                  controller.updateProduct(widget.product.id ?? '');
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}