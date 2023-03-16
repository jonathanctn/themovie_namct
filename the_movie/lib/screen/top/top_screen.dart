import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie/app_routes.dart';
import 'package:the_movie/screen/top/top_viewmodel.dart';

class TopScreen extends GetView<TopViewModel> {
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                 Get.toNamed(Routes.listMovie);
                },
                child: Text("Go to next screen"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
