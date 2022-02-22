import 'dart:math';

import 'package:ch5_practical/core/platform_alert_dialog.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_event.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_state.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/error_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/safe_network_image_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/news_horizontal_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBarPage extends StatelessWidget {
  const FavouriteBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Favourites',
              style: TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: BlocBuilder<DBloc, DBState>(
              /*buildWhen: (DBState previous, DBState current) =>
              previous.runtimeType != current.runtimeType,*/
              builder: (_, DBState state) {
                if (state is Initial) {
                  context.read<DBloc>().add(const GetAllFavourites());
                }
                if (state is Loading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.separated(
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                      itemBuilder: (_, __) => NewsHorizontalLoading(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                  );
                }
                if (state is Failed) {
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ErrorCard(
                        head: state.exclaim,
                        title: state.title,
                        desc: state.message,
                      ),
                    ),
                  );
                }
                if (state is Complete<List<Article>>) {
                  return ListView.separated(
                    itemCount: state.data.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                    itemBuilder: (_, int index) {
                      String _tag = Random().nextInt(1000).toString();
                      return GestureDetector(
                        onTap: () => handleArticleNavigation(
                          <String, dynamic>{
                            'data': state.data[index],
                            'tag': _tag,
                          },
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Hero(
                            tag: _tag,
                            child: Dismissible(
                              key: ValueKey(state.data[index].id),
                              background: ColoredBox(
                                color: Theme.of(context).colorScheme.error,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(Icons.delete_outline_outlined),
                                      Icon(Icons.delete_outline_outlined),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (_) {
                                context.read<DBloc>().add(
                                    RemoveFavourite(state.data[index].id!));
                              },
                              confirmDismiss: (_) {
                                return showDialog<bool>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const PlatformAlertDialog(
                                    title: Text('Remove Favourite Article'),
                                    description: Text(
                                        'Are you sure you want to remove this article?'),
                                    positiveText: Text('Yes'),
                                    negativeText: Text('No'),
                                  ),
                                );
                              },
                              child: Material(
                                type: MaterialType.card,
                                elevation: 10,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //TODO: save image as string and load in memory
                                    SafeImageLoad(
                                      src: state.data[index].urlToImage,
                                      width: 130,
                                      height: 130,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.data[index].title,
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  ?.copyWith(fontSize: 18),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                state.data[index].publishedAt,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                            Text(
                                              state.data[index].description,
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: const ErrorCard(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.all(16),
                  elevation: 6.0,
                  shape: const CircleBorder(),
                ),
                onPressed: () async {
                  final bool? _shouldDelete = await showDialog<bool>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const PlatformAlertDialog(
                      title: Text('Remove Favourites'),
                      description: Text(
                        'Are you sure you want to remove all the articles?',
                      ),
                      positiveText: Text('Yes'),
                      negativeText: Text('No'),
                    ),
                  );
                  if (_shouldDelete == true) {
                    context.read<DBloc>().add(const DeleteAllFavourites());
                  }
                },
                child: const Icon(Icons.delete_outline_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
