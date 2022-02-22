class Product {
  String title = "";
  String description = "";
  String price = "";
  String quantity = "";
  String id = "";

  toJson() {
    return {
      'title': title.toString(),
      'description': description.toString(),
      'price': price.toString(),
      'quantity': quantity.toString(),
      '_id': id.toString()
    };
  }
}
