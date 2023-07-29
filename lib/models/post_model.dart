class PostModel {
  String? image;
  String? uID;
  String? name;

  String? postText;
  String? postImage;
  String? postDateTime;


  PostModel(
  {
    this.image,
    this.uID,
    this.name,

    this.postText,
    this.postImage,
    this.postDateTime,
 }
  );

  PostModel.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    postDateTime = json['postDateTime'];
    postText = json['postText'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'image': image,
      'postText': postText,
      'postImage': postImage,
      'postDateTime': postDateTime,

    };
  }

  @override
  String toString() {
    return 'PostModel{image: $image, uID: $uID, name: $name, postText: $postText, postImage: $postImage, postDateTime: $postDateTime}';
  }
}
