import 'package:ch5_practical/article_page_widgets/article_future.dart';
import 'package:ch5_practical/article_page_widgets/category_future.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBarPage extends StatefulWidget {
  const HomeBarPage({Key? key, required this.onActionTap}) : super(key: key);

  final ChangePage<int> onActionTap;

  @override
  _HomeBarPageState createState() => _HomeBarPageState();
}

class _HomeBarPageState extends State<HomeBarPage> {
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
                      elevation: 12,
                      shadowColor: Colors.grey.shade50,
                      type: MaterialType.card,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade400,
                            size: 30,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
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
                  onPressed: () => widget.onActionTap(storeIndex),
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
