import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';

class HomeController extends GetxController {
  RxList<String> sliders = <String>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxString tokens = RxString('');
  var isLoading = true.obs;

  @override
  onInit() {
    super.onInit();
    getSliders();
    getProducts();
    getCategories();
  }

  getSliders() async {
    final data = await FirebaseFirestore.instance.collection("sliders").get();

    for (var element in data.docs) {
      print(element.data()['data']);
      sliders.add(element.data()['data']);
    }
    update();
  }

  getCategories() async {
    final data =
        await FirebaseFirestore.instance.collection("categories").get();
    // print(data.docs.length);
    // print(data.docs.first.data()['name']);
  }

  getProducts() async {
    try {
      isLoading(true);
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      products.value = querySnapshot.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      // print("Products Length:  ${products.length}");
      // print("Products Length:  ${products.first.productName}");
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
    update();
  }
}
