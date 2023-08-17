import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_my_favorites/models/shoe.dart';

List<Shoe> initialData = List.generate(
    20,
    (index) => Shoe(
      title: 'Botas ${index + 1}',
      price: double.parse((Random().nextInt(75) * index + 25).toString()),
      image: 'assets/images/boots.png',
    )
);

class ShoeProvider extends ChangeNotifier {

  List<Shoe> _shoes = initialData;
  List<Shoe> get shoes => _shoes;

  List<Shoe> _myFavorites = [];
  List<Shoe> get myFavorites => _myFavorites;

  void addToMyFavorites(Shoe shoe) {
    _myFavorites.add(shoe);
    notifyListeners();
  }

  void removeFromMyFavorites(Shoe shoe) {
    _myFavorites.remove(shoe);
    notifyListeners();
  }
}