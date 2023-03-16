import 'dart:convert';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_movie/core/constants.dart';
import 'package:the_movie/data/movie_model.dart';

class ListViewViewModels extends GetxController {
  RxList<Movie> listMovie = <Movie>[].obs;
  int numberPage = 1;

  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      var receivePort = ReceivePort();
      Isolate.spawn(getDataInNewIsolate, [numberPage, receivePort.sendPort]);
      receivePort.listen((message) {
        if (message is List<Movie>) {
          listMovie.addAll(message);
        }
      });
    } catch (e) {
      e.printError();
    }
  }

  static Future<void> getDataInNewIsolate(List<dynamic> args) async {
    int page = args[0];
    var sendPort = args[1] as SendPort;
    final response = await http.get(
        Uri.parse('${K.baseUrl}discover/movie?api_key=${K.apiKey}&page=$page'));
    if (response.statusCode == 200) {
      var data = Movies.fromJson(json.decode(response.body));
      sendPort.send(data.results);
    } else {
      // TODO : handler error
    }
  }
}
