import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/themes.dart';
import '../../data/models/movie_model.dart';
import '../bloc/search/movie/movie_bloc.dart';
import '../bloc/search/movie/movie_event.dart';
import '../bloc/search/movie/movie_state.dart';
import '../widgets/item_table.dart';
import 'camera_view.dart';

class MovieInfoView extends StatefulWidget {
  final int movieId;

  const MovieInfoView({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieInfoView> createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView> {
  @override
  void initState() {
    super.initState();

    context.read<MovieBloc>().add(MovieSearchEvent(id: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorOf.point.light,
        child: const Icon(Icons.camera_alt_outlined),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CameraView()));
        },
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieDataLoaded) {
            MovieModel movieItem = state.movie as MovieModel;
            String castingList = movieItem.movieCastList.join(", ");
            List<String> imageUrl =
                movieItem.sceneImages.map((scene) => scene.imageUrl).toList();

            return Center(
              child: ItemTable(
                header: ItemHeader(
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: SizeOf.w_md),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: ColorOf.white.light,
                        ),
                      ),
                    )
                  ],
                  forceElevated: true,
                  collapsedHeight: 160.h,
                  expandedHeight: 328.h,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const Alignment(0.00, -1.00),
                        end: const Alignment(0, 1),
                        colors: [Colors.black.withOpacity(0.9), Colors.black],
                      ),
                    ),
                    child: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.symmetric(
                        horizontal: SizeOf.w_lg,
                        vertical: SizeOf.h_lg,
                      ),
                      expandedTitleScale: 1,
                      centerTitle: false,
                      title: LayoutBuilder(
                        builder: (context, constraints) {
                          return FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.network(
                                  movieItem.posterUrl!,
                                  width: 100.w,
                                  height: 144.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: SizeOf.w_md),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        child: Text(
                                          movieItem.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .apply(
                                                color: ColorOf.white.light,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 3.h),
                                        child: Text(
                                          movieItem.company!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .apply(
                                                color: ColorOf.white.light,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        '${movieItem.openDate!.year}-${movieItem.openDate!.month}-${movieItem.openDate!.day} 개봉 | ${movieItem.rating}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .apply(
                                              color: ColorOf.white.light,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      background: ShaderMask(
                        shaderCallback: (bound) {
                          return LinearGradient(
                            begin: const Alignment(0.00, -1.00),
                            end: const Alignment(0, 1),
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.black
                            ],
                          ).createShader(bound);
                        },
                        blendMode: BlendMode.colorBurn,
                        child: Image.network(
                          movieItem.posterUrl!,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                sections: [
                  ItemSection.onlyPost(
                    builder: ItemSectionBuilder()
                      ..posts = [
                        ItemTablePost(
                          title: '감독',
                          content: movieItem.director!,
                        ),
                        ItemTablePost(
                          title: '출연',
                          content: castingList,
                        ),
                        ItemTablePost(
                          title: '시놉시스',
                          content: movieItem.plot!,
                        ),
                      ],
                  ),
                  if (imageUrl.isNotEmpty)
                    ItemSection(
                      builder: ItemSectionBuilder()
                        ..image = ItemTableGrid(
                          title: '스틸컷',
                          items: imageUrl,
                        ),
                    ),
                ],
              ),
            );
          }
          return const SizedBox(
            child: SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
