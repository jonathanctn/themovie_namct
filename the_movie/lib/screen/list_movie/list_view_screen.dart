import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie/core/constants.dart';
import 'package:the_movie/data/movie_model.dart';
import 'package:the_movie/screen/list_movie/list_view_viewmodel.dart';

class ListMovieScreen extends GetView<ListViewViewModels> {
  const ListMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 120,
        leading: Row(
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              label: const Text(
                "Back",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.listMovie.isEmpty
            ? const Center(child: Text("Please wait ..."))
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollPos) {
                  if (scrollPos is ScrollEndNotification) {
                    controller.numberPage++;
                    controller.getData();
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Popular list",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                        Obx(
                          () => GridView.builder(
                            itemCount: controller.listMovie.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = controller.listMovie[index];
                              String decimal =
                                  movie.voteAverage.toString().substring(2, 3);
                              String? year;
                              if (movie.releaseDate == null) {
                                year = "No data";
                              } else {
                                year = movie.releaseDate!.length < 4
                                    ? ""
                                    : movie.releaseDate
                                        .toString()
                                        .substring(0, 4);
                              }
                              return ItemGrillView(
                                movie: movie,
                                decimal: decimal,
                                year: year,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class ItemGrillView extends StatelessWidget {
  const ItemGrillView({
    super.key,
    required this.movie,
    required this.decimal,
    required this.year,
  });

  final Movie movie;
  final String decimal;
  final String? year;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 30,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "${K.baseUrlImage}${movie.backdropPath}",
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Placeholder();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: <Color>[
                              Color(0xffef0c03),
                              Color(0xffd91d19),
                              Colors.orange,
                              Colors.yellow
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${movie.voteAverage?.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  ".$decimal",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                const Spacer(),
                Text(
                  year!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${movie.originalTitle?.toUpperCase()}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
