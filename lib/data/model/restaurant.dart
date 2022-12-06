import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
    Menus? menus,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      menus: menus ?? this.menus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'menus': menus.toMap(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      menus: Menus.fromMap(map['menus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, description: $description, pictureId: $pictureId, city: $city, rating: $rating, menus: $menus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.pictureId == pictureId &&
        other.city == city &&
        other.rating == rating &&
        other.menus == menus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        pictureId.hashCode ^
        city.hashCode ^
        rating.hashCode ^
        menus.hashCode;
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;
  Menus({
    required this.foods,
    required this.drinks,
  });

  Menus copyWith({
    List<Food>? foods,
    List<Drink>? drinks,
  }) {
    return Menus(
      foods: foods ?? this.foods,
      drinks: drinks ?? this.drinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Food>.from(map['foods']?.map((x) => Food.fromMap(x))),
      drinks: List<Drink>.from(map['drinks']?.map((x) => Drink.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menus.fromJson(String source) => Menus.fromMap(json.decode(source));

  @override
  String toString() => 'Menus(foods: $foods, drinks: $drinks)';
}

class Food {
  final String name;
  Food({
    required this.name,
  });

  Food copyWith({
    String? name,
  }) {
    return Food(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));

  @override
  String toString() => 'Food(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Food && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class Drink {
  final String name;
  Drink({
    required this.name,
  });

  Drink copyWith({
    String? name,
  }) {
    return Drink(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Drink.fromJson(String source) => Drink.fromMap(json.decode(source));

  @override
  String toString() => 'Drink(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Drink && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
