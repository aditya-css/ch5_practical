import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/article_future.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/category_future.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBarPage extends StatelessWidget {
  const HomeBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Material(
                      elevation: 20,
                      shadowColor: Colors.grey.shade50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade300,
                            size: 30,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const CategoryFuturePage(),
                  const ArticleFuturePage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () =>
                      context.read<BottomNavStore>().onItemTap(storeIndex),
                  child: const Icon(CupertinoIcons.cart_fill),
                  tooltip: 'Store',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
