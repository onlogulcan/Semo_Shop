class Categories {
  int id;
  String name;
  String pictureUrl;

  Categories({this.id, this.name, this.pictureUrl});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pictureUrl'] = this.pictureUrl;
    return data;
  }
}
class GetKategori {
  int id;
  String name;
  double price;
  int stock;
  String barcode;
  String pictureUrl;
  String weight;
  int categoryId;

  GetKategori(
      {this.id,
        this.name,
        this.price,
        this.stock,
        this.barcode,
        this.pictureUrl,
        this.weight,
        this.categoryId});

  GetKategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    barcode = json['barcode'];
    pictureUrl = json['pictureUrl'];
    weight = json['weight'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['barcode'] = this.barcode;
    data['pictureUrl'] = this.pictureUrl;
    data['weight'] = this.weight;
    data['categoryId'] = this.categoryId;
    return data;
  }
}