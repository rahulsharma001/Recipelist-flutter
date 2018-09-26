class FetchData{
  final String title;
  final String description;
    final String imageUrl;

    FetchData({this.title,this.description,this.imageUrl});

    factory FetchData.fromJson(Map<String,dynamic> json){
      return new FetchData(
        title: json['title'],
        description: json['description'],
        imageUrl: json['user_photo']
      );
    }


}