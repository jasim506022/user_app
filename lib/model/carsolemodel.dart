import 'package:flutter/material.dart';

class CarosleModel {
  final String category;
  final String title;
  final String number;
  final String image;
  final Color color;

  CarosleModel(
      {required this.category,
      required this.title,
      required this.number,
      required this.image,
      required this.color});
}

List<CarosleModel> caroselList = [
  CarosleModel(
    category: "Organice Food",
    title: "Savon Stories",
    number: "Buy 1 get 1 free",
    image: "asset/gridicon/orange.png",
    color: const Color.fromARGB(255, 245, 216, 219),
  ),
  CarosleModel(
    category: "Milk",
    title: "Savon Stories",
    number: "Buy 1 get 1 free",
    image: "asset/image/milk.png",
    color: const Color.fromARGB(255, 216, 230, 245),
  ),
  CarosleModel(
    color: const Color.fromARGB(255, 202, 242, 219),
    category: "Fresh Vegetable",
    title: "Fresh Vegetable Stories",
    number: "Buy 1 get 1 free",
    image: "asset/image/vegetable.png",
  ),
  CarosleModel(
    color: const Color.fromARGB(255, 242, 245, 216),
    category: "Fruits",
    title: "Fresh Fruits Stories",
    number: "Buy 1 get 1 free",
    image: "asset/image/fruits.png",
  ),
];
