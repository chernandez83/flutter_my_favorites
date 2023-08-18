import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_my_favorites/models/shoe.dart';
import 'package:flutter_my_favorites/provider/shoe_provider.dart';
import 'package:provider/provider.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyFavoritesScreenScreenState();

}

class MyFavoritesScreenScreenState extends State<MyFavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    var myFavorites = context.watch<ShoeProvider>().myFavorites;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade200,
        elevation: 15,
        title: Text(
          'Mis Favoritos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: GridView.builder(
          itemCount: myFavorites.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            Shoe shoe = myFavorites[index];
            return Card(
              key: ObjectKey(shoe),
              color: Colors.white,
              elevation: 1,
              child: Column(
                children: [
                  Image.asset(
                    shoe.image,
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    shoe.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '\$${shoe.price.toString()}',
                    //style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<ShoeProvider>().removeFromMyFavorites(shoe);
                      },
                      child: const Text(
                        'Eliminar',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

}