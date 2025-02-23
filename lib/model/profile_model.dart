import '../res/app_constant.dart';

class ProfileModel {
  String? address;

  String? email;
  String? imageurl;
  String? name;
  String? phone;
  String? status;
  String? uid;
  String? token;
  List<dynamic>? cartlist;
  ProfileModel({
    this.address,
    this.email,
    this.imageurl,
    this.name,
    this.phone,
    this.status,
    this.uid,
    this.token,
    this.cartlist,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'email': email,
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'status': status,
      'uid': uid,
      'cartlist': cartlist,
      'token': token
    };
  }

  Map<String, dynamic> toMapProfileEdit() {
    return <String, dynamic>{
      'address': address,
      'email': AppConstant.sharedPreference!.getString("email"),
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'status': "approved",
      'token': token,
      'uid': AppConstant.sharedPreference!.getString("uid"),
      'cartlist': AppConstant.sharedPreference!.getStringList("cartlist"),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      address: map['address'] != null ? map['address'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      imageurl: map['imageurl'] != null ? map['imageurl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      cartlist: map['cartlist'],
    );
  }
}
