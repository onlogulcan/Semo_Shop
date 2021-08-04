class AddOrder {
  int id;
  int userId;
  int status;
  double totalPrice;
  int isPaid;
  String date;
  String adress;

  AddOrder(
      {this.id,
        this.userId,
        this.status,
        this.totalPrice,
        this.isPaid,
        this.date,
        this.adress});

  AddOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    isPaid = json['isPaid'];
    date = json['date'];
    adress = json['adress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['totalPrice'] = this.totalPrice;
    data['isPaid'] = this.isPaid;
    data['date'] = this.date;
    data['adress'] = this.adress;
    return data;
  }
}

class OrderProduct {
  int id;
  int productId;
  int orderId;
  int quantity;
  int price;

  OrderProduct(
      {this.id, this.productId, this.orderId, this.quantity, this.price});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    orderId = json['orderId'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['orderId'] = this.orderId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}