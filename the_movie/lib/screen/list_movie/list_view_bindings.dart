import 'package:get/get.dart';
import 'package:the_movie/screen/list_movie/list_view_viewmodel.dart';

class ListViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListViewViewModels>(() => ListViewViewModels());
  }
}
