class Users {
  String userName;
  String password;

  Users({this.userName, this.password});

  Users.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}
class UsersRequest {
  String username;
  String password;
  String email;
  String phone;

  UsersRequest({this.username, this.password, this.email, this.phone});

  UsersRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class GetUSer {
  int id;
  String username;
  String passwordHash;
  String passwordSalt;
  String email;
  String phone;
  int roleId;
  int verified;

  GetUSer(
      {this.id,
        this.username,
        this.passwordHash,
        this.passwordSalt,
        this.email,
        this.phone,
        this.roleId,
        this.verified});

  GetUSer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    passwordHash = json['passwordHash'];
    passwordSalt = json['passwordSalt'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['roleId'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['passwordHash'] = this.passwordHash;
    data['passwordSalt'] = this.passwordSalt;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['verified'] = this.verified;
    return data;
  }
}