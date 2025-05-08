import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store_admin/Model/categorie_model.dart';
import '../Controller/category_controller.dart';
import '../utils/Elevated Button/cs_elevated_button.dart';
import '../utils/TextFormField/cs_text_form_field.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            //Category name
            CSTextFormField(
              label: 'Category Name',
              hintText: 'Enter Category Name',
              controller: controller.nameController,
            ),
            //Featured Category
            Obx(
              () => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Featured Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                value: controller.isFeatured.value,
                onChanged: (value) {
                  controller.isFeatured.value = value ?? false;
                },
              ),
            ),
            SizedBox(height: 10),
            //Add Category
            CSElevatedButton(
              text: 'Add Category',
              onPressed: () {
                final category = CategoriesModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: controller.nameController.text,
                  image: controller.imageController.text,
                  parentId: controller.parentIdController.text,
                  isFeatured: controller.isFeatured.value,
                );
                controller.addCategory(category);
              },
            ),
          ],
        ),
      ),
    );
  }
}