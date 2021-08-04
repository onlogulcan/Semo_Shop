class Urun {
  int id;
  String name;
  double price;
  double priceDto;
  int stock;
  String barcode;
  String pictureUrl;
  String weight;
  int categoryId;

  Urun(
      {this.id,
        this.name,
        this.price,
        this.priceDto,
        this.stock,
        this.barcode,
        this.pictureUrl,
        this.weight,
        this.categoryId});

  Urun.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map =  Map<String ,dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;
    map['price'] = this.price;
    map['stock'] = this.stock;
    map['barcode'] = this.barcode;
    map['pictureUrl'] = this.pictureUrl;
    map['weight'] = this.weight;
    map['categoryId'] = this.categoryId;
    return map;

  }
}