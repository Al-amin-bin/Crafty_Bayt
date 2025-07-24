class SliderModel {
  final String id;
  final String photoUrl;
  final String description;
  final String branchID;

  SliderModel(
      {required this.id,
      required this.photoUrl,
      required this.description,
      required this.branchID});

  factory SliderModel.fromJson(Map<String, dynamic> jsonData) {
    return SliderModel(
        id: jsonData['_id'] ?? '',
        photoUrl: jsonData['photo_url'],
        description: jsonData['description'],
        branchID: jsonData['brand']);
  }

  Map<String, dynamic> toJson(){
    return{
      '_id':id,
      'photo_url': photoUrl,
      'description': description,
      'brand': branchID,
    };
  }
}
