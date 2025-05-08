import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:kh_online_store_admin/Model/product_model.dart';

import '../Data/Repository/category_repository.dart';
import '../Model/categorie_model.dart';
import '../utils/Message Alart/alert_message.dart';

class AddProductController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final categoryRepository = Get.put(CategoryRepository());
  final _db = FirebaseFirestore.instance;
  late CollectionReference productionCollection;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productIdController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  RxString category = ''.obs;
  List<Product> products = [];
  List <CategoriesModel>categories = [];
  RxBool isFeatured = false.obs;
  List<String> imageUrls = [];
  final ImagePicker _picker = ImagePicker();
  var selectedImageNames = <String>[].obs;
  List<File> selectedImageFiles = [];
  File? selectedThumbnailFile;
  var thumbnailUrl = ''.obs;
  var isLoading = false.obs;
  var selectedColors = <String>[].obs;
  var selectedSizes = <String>[].obs;

  @override
  Future<void> onInit() async {
    productionCollection = fireStore.collection('Products');
    await fetchProduct();
    await fetchCategories();
    super.onInit();
  }

  //Add product
  addProducts() {
    try {
      String customDocId =
          productIdController.text; // Use the product ID from the controller
      DocumentReference doc = productionCollection.doc(customDocId);
      Product product = Product(
        id: customDocId,
        name: productNameController.text,
        images: imageUrls,
        category: category.value,
        description: productDescriptionController.text,
        price: double.parse(productPriceController.text),
        isFeatured: isFeatured.value,
        thumbnail: thumbnailUrl.value,
        colors: selectedColors,
        sizes: selectedSizes,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      setValueDefault();
      showAlert(Get.context!, 'Product added successfully');
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Add methods to add and remove colors and sizes
  void addColor(String color) {
    selectedColors.add(color);
  }

  void removeColor(int index) {
    selectedColors.removeAt(index);
  }

  void addSize(String size) {
    selectedSizes.add(size);
  }

  void removeSize(int index) {
    selectedSizes.removeAt(index);
  }

  // Select thumbnail image
  Future<void> pickThumbnail() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    selectedThumbnailFile = File(selectedImage!.path);
    await uploadThumbnail(selectedThumbnailFile!);
  }

  // Upload thumbnail image to firebase storage
  Future<void> uploadThumbnail(File image) async {
    try {
      isLoading.value = true;
      String fileName = basename(image.path);
      Reference storageRef = FirebaseStorage.instance.ref().child(
        'thumbnails/$fileName',
      );
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      thumbnailUrl.value = downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  //Remove Thumbnail
  void removeThumbnail() {
    selectedThumbnailFile = null;
    thumbnailUrl.value = '';
  }

  //Select image
  Future<void> pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    selectedImageNames.value =
        selectedImages.map((xFile) => xFile.name).toList();
    selectedImageFiles =
        selectedImages.map((xFile) => File(xFile.path)).toList();
    await uploadImages(selectedImageFiles);
  }

  //Upload images to firebase storage
  Future<void> uploadImages(List<File> images) async {
    try {
      for (var image in images) {
        String fileName = basename(image.path);
        Reference storageRef = FirebaseStorage.instance.ref().child(
          'products/$fileName',
        );
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Remove selected image
  void removeSelectedImage(int index) {
    selectedImageNames.removeAt(index);
  }
  // Fetch categories
  Future<void> fetchCategories() async {
    try {
       _db.collection('categories').snapshots().listen((snapshot) {
            categories.clear(); // Clear the list before adding new data
            for (var doc in snapshot.docs) {
              categories.add(CategoriesModel.fromJson(doc.data()));
            }
            update();
          });

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Fetch all Product
  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot = await productionCollection.get();
      products =
          querySnapshot.docs.map((doc) {
            return Product.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }finally{
      isLoading.value = false;
    }
  }

  //Delete product
  deleteProduct(String id) async {
    try {
      await productionCollection.doc(id).delete();
      await fetchProduct(); // Ensure the product list is updated
      update();
      showAlert(Get.context!, 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  setValueDefault() {
    productNameController.clear();
    productIdController.clear();
    productDescriptionController.clear();
    selectedImageNames.clear();
    productPriceController.clear();
    selectedColors.clear();
    selectedSizes.clear();
    imageUrls.clear();
    colorController.clear();
    sizeController.clear();
    categories.clear();
    thumbnailUrl.value = '';
    isFeatured.value = false;
    category = ''.obs;
    update();
  }
}