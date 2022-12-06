import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = 'detailPage';
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(restaurant.pictureId),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                restaurant.name,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 18,
                    color: Colors.black54,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        restaurant.description,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Drinks'),
                      const SizedBox(height: 10),
                      MenuGridView(
                        drinks: restaurant.menus.drinks,
                      ),
                      const SizedBox(height: 10),
                      const Text('Foods'),
                      const SizedBox(height: 10),
                      MenuGridView(
                        foods: restaurant.menus.foods,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuGridView extends StatelessWidget {
  const MenuGridView({
    Key? key,
    this.drinks,
    this.foods,
  }) : super(key: key);

  final List<Drink>? drinks;
  final List<Food>? foods;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: drinks != null ? drinks!.length : foods!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black45,
                        ],
                      ),
                    ),
                  ),
                  drinks != null
                      ? Image.network(
                          'https://cdni.iconscout.com/illustration/premium/thumb/cold-drink-3378206-2810767.png',
                          fit: BoxFit.contain,
                        )
                      : Image.asset('assets/images/foods.png'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      drinks != null ? drinks![index].name : foods![index].name,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
