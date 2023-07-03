class PhotosModel {
  String imgSrc;
  String PhotoName;

  PhotosModel({required this.PhotoName, required this.imgSrc});

  static PhotosModel formAPI2App(Map<String, dynamic> photoMap) {
    return new PhotosModel(
        PhotoName: photoMap["photographer"],
        imgSrc: (photoMap["src"])["portrait"]);
  }
}
