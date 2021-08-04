class Basket {
  int id;
  int productId;
  int clientId;
  int quantity;
  double totalPrice;
  String deviceId;

  Basket(
      {this.id,
        this.productId,
        this.clientId,
        this.quantity,
        this.totalPrice,
        this.deviceId});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    clientId = json['clientId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['clientId'] = this.clientId;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['deviceId'] = this.deviceId;
    return data;
  }
}


