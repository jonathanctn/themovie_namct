import 'package:get/get.dart';
import 'package:the_movie/screen/top/top_viewmodel.dart';

class TopBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TopViewModel>(() => TopViewModel());
  }

}