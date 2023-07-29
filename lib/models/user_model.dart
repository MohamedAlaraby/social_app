class UserModel {
  String? cover;
  String? image;
  String? uID;
  String? phone;
  String? name;
  String? bio;

  String? email;

  UserModel(
      {this.cover,
        this.image,
        this.uID,
        this.phone,
        this.name,
        this.bio,
        this.email
      });
  UserModel.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    image = json['image'];
    uID = json['uID'];
    phone = json['phone'];
    name = json['name'];
    bio = json['bio'];
    email = json['email'];
  }


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }

  @override
  String toString() {
    return 'UserModel{cover: $cover, image: $image, uID: $uID, phone: $phone, name: $name, bio: $bio, email: $email}';
  }
}

