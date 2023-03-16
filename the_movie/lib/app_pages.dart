import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:the_movie/screen/list_movie/list_view_bindings.dart';
import 'package:the_movie/screen/list_movie/list_view_screen.dart';
import 'package:the_movie/screen/top/top_bindings.dart';
import 'package:the_movie/screen/top/top_screen.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = Routes.top;

  static final routes = [
    GetPage(
      name: Routes.top,
      page: () => const TopScreen(),
      binding: TopBindings()

    ),
    GetPage(
      name: Routes.listMovie,
      page: () => const ListMovieScreen(),
      binding: ListViewBindings()

    ),


  ];
}