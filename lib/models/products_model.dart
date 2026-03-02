import 'package:equatable/equatable.dart';
import 'package:nicestore/core/data/safe_json.dart';

class Products extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  Products copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) => Products(
    id: id ?? this.id,
    title: title ?? this.title,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    image: image ?? this.image,
    rating: rating ?? this.rating,
  );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: (json["id"]),
    title: json["title"],
    price: SafeJsonData.doubleSafe(json["price"]),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    price,
    description,
    category,
    image,
    rating,
  ];
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Rating copyWith({double? rate, int? count}) =>
      Rating(rate: rate ?? this.rate, count: count ?? this.count);

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: json["rate"]?.toDouble(), count: json["count"]);

  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}

final List<Products> dummyProducts = [
  Products(
    id: 1,
    title: "Fjallraven - Foldsack No. 1 Backpack",
    price: 109.95,
    description: "Perfect pack for everyday use.",
    category: "men's clothing",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
    rating: Rating(rate: 3.9, count: 120),
  ),
  Products(
    id: 2,
    title: "Mens Casual Premium Slim Fit T-Shirts",
    price: 22.3,
    description: "Slim-fitting style, lightweight fabric.",
    category: "men's clothing",
    image:
        "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
    rating: Rating(rate: 4.1, count: 259),
  ),
  Products(
    id: 5,
    title: "John Hardy Women's Legends Naga Bracelet",
    price: 695,
    description: "Gold & Silver Dragon Station Chain Bracelet.",
    category: "jewelery",
    image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png",
    rating: Rating(rate: 4.6, count: 400),
  ),
  Products(
    id: 9,
    title: "WD 2TB Elements Portable External Hard Drive",
    price: 64,
    description: "USB 3.0 Compatibility. Fast data transfers.",
    category: "electronics",
    image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_t.png",
    rating: Rating(rate: 3.3, count: 203),
  ),
  Products(
    id: 18,
    title: "MBJ Women's Solid Short Sleeve Boat Neck",
    price: 9.85,
    description: "Lightweight fabric with great stretch.",
    category: "women's clothing",
    image: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_t.png",
    rating: Rating(rate: 4.7, count: 130),
  ),
];
