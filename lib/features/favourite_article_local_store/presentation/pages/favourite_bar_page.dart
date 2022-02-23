import 'dart:io';
import 'dart:math' show Random;

import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/core/widgets/article_horizontal_view.dart';
import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/core/widgets/platform_alert_dialog.dart';
import 'package:ch5_practical/core/widgets/shimmer_widgets/favourite_article_loading_widget.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_event.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_state.dart';
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07,
            ),
            child: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (_, DatabaseState state) {
                if (state is Initial) {
                  context.read<DatabaseBloc>().add(const GetAllFavourites());
                }
                if (state is Loading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FavouritesLoadingShimmer(
                      articleCount: 4,
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.4,
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
                        description: state.message,
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
                                context.read<DatabaseBloc>().add(
                                      RemoveFavourite(state.data[index].id!),
                                    );
                              },
                              confirmDismiss: (_) {
                                return showDialog<bool>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => PlatformAlertDialog(
                                    showIOSDialog: Platform.isIOS,
                                    title:
                                        const Text('Remove Favourite Article'),
                                    description: const Text(
                                      'Are you sure you want to remove this article?',
                                    ),
                                    positiveText: const Text('Yes'),
                                    negativeText: const Text('No'),
                                  ),
                                );
                              },
                              child: ArticleViewHorizontal(
                                state.data[index],
                                elevation: 10,
                                imgHeight: 130,
                                imgWidth: 130,
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
                    builder: (_) => PlatformAlertDialog(
                      showIOSDialog: Platform.isIOS,
                      title: const Text('Remove Favourites'),
                      description: const Text(
                        'Are you sure you want to remove all the articles?',
                      ),
                      positiveText: const Text('Yes'),
                      negativeText: const Text('No'),
                    ),
                  );
                  if (_shouldDelete == true) {
                    context
                        .read<DatabaseBloc>()
                        .add(const DeleteAllFavourites());
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
