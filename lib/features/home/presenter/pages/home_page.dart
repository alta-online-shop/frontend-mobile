import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_mobile/features/home/bloc/home_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_event.dart';
import 'package:frontend_mobile/features/home/bloc/home_state.dart';
import 'package:frontend_mobile/features/login/bloc/login_bloc.dart';
import 'package:frontend_mobile/features/login/bloc/login_event.dart';
import 'package:frontend_mobile/features/login/bloc/login_state.dart';
import 'package:frontend_mobile/features/login/presenter/pages/login_page.dart';
import 'package:frontend_mobile/services/category/category_service.dart';
import 'package:frontend_mobile/services/product/product_service.dart';

class HomePage extends StatefulWidget {
  static const path = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(context).add(GetAllProducts());
      BlocProvider.of<LoginBloc>(context).stream.listen((state) {
        setState(() {
          isLoggedIn = (state.token ?? '').isNotEmpty;
        });
      });
    });
  }

  Widget buildThumbnail(
    BuildContext context,
    Product product,
  ) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.description ?? '',
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                ),
                Wrap(
                  children: [
                    for (var category in product.categories ?? <Category>[])
                      Chip(
                        label: AutoSizeText(
                          category.name,
                          style: const TextStyle(fontSize: 10),
                        ),
                        labelPadding: const EdgeInsets.all(0),
                      ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                AutoSizeText.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Rp ',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: '${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 30,
                  child: OutlinedButton(
                    child: const Text('Beli'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: !isLoggedIn
                ? const Icon(Icons.login)
                : const Icon(Icons.logout),
            onPressed: () {
              if (!isLoggedIn) {
                Navigator.of(context).pushNamed(LoginPage.path);
              } else {
                BlocProvider.of<LoginBloc>(context).add(LoginClean());
              }
            },
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(2, 2),
                const QuiltedGridTile(2, 1),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => index >= state.products.length
                  ? null
                  : buildThumbnail(context, state.products[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Badge(
          child: const Icon(Icons.shopping_cart_outlined),
          badgeContent: const Text('0'),
          badgeColor: Colors.white,
        ),
        onPressed: () {
          // TODO: go to cart page
        },
      ),
    );
  }
}
