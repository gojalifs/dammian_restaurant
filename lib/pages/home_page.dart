import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:dammian_restaurant/data/model/restaurant.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> restaurants = [];

  /// Init the restaurant data from API
  @override
  void initState() {
    getRestaurantList().then((value) => restaurants = value);
    super.initState();
  }

  /// title header section
  SliverPersistentHeader _header(String text) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60,
        maxHeight: 150,
        child: GestureDetector(
          onTap: () => getRestaurantList(),
          child: Container(
            color: Colors.amber.shade400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// body section
  ListView bodyRestaurantList(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: restaurants
          .map(
            (e) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: e);
              },
              child: Card(
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Hero(
                        tag: e.pictureId,
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(e.pictureId),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber.shade100,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            e.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                e.city,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${e.rating}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Future<List<Restaurant>> getRestaurantList() async {
    var source = await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
    List data = jsonDecode(source);
    List resto = data;
    List<Restaurant> res = resto.map((e) => Restaurant.fromMap(e)).toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _header('Dammian Restaurant'),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder(
                    future: Future.delayed(
                      const Duration(seconds: 2),
                    ).then(
                      (value) => DefaultAssetBundle.of(context)
                          .loadString('assets/local_restaurant.json'),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return bodyRestaurantList(context);
                        }
                        return const Center(
                          child: Text('No Data Available'),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Create sliverappbar for delegate the sliverpersistentheader
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
