class Product {
  String? id;
  String? name;
  String? description;
  int? price;
  List<Map<String, String>>? history;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.history,
  });

  static Map<String, String> createHistoryEntry(String action, String details) {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'action': action,
      'details': details,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'history': history?.map((e) => e).toList(),
    };
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        history = (json['history'] as List<dynamic>?)
            ?.map((e) => Map<String, String>.from(e))
            .toList();

  void addHistoryEntry(String action, String details) {
    history = history ?? [];
    history!.add(Product.createHistoryEntry(action, details));
  }
}