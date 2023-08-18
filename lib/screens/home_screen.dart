import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_my_favorites/models/shoe.dart';
import 'package:flutter_my_favorites/provider/shoe_provider.dart';
import 'package:flutter_my_favorites/screens/my_favorites_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var myFavorites = context.watch<ShoeProvider>().myFavorites;
    var shoes = context.watch<ShoeProvider>().shoes;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        elevation: 15,
        title: Text(
          'Productos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -2, end: 5),
            badgeContent: Text(
              myFavorites.length.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.deepOrangeAccent.shade700,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyFavoritesScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: shoes.length,
          itemBuilder: (context, index) {
            Shoe shoe = shoes[index];
            return Card(
              key: ObjectKey(shoe),
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
                leading: Image.asset(shoe.image, width: 100, height: 100,),
                title: Text(
                  shoe.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  '\$${shoe.price.toString()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: myFavorites.contains(shoe) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if(myFavorites.contains(shoe)) {
                      context.read<ShoeProvider>().removeFromMyFavorites(shoe);
                    } else {
                      context.read<ShoeProvider>().addToMyFavorites(shoe);
                    }
                  },
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}