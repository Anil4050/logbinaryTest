import 'package:get/get.dart';

import '../Controller/ListScreenController.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => ListScreenController());
  }
}
