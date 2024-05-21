class Money {
  String? icon;
  String? nameCategory;
  String? name;
  String? time;
  String? type;
  String ? price;

  Money({
    this.icon,
    this.nameCategory,
    this.name,
    this.time,
    this.type,
    this.price,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      icon: json['icon'],
      nameCategory: json['name'],// Assuming 'image' is the correct field
      name: json['name'],
      time: json['date'],
      type: json['type'],
      price: json['price'] , // Converting to double if needed
    );
  }
}
