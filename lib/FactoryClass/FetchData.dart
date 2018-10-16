class FetchData{
  final String title;
  final String description;
    final String imageUrl;
    final int id;

    FetchData({this.title,this.description,this.imageUrl,this.id});

    factory FetchData.fromJson(Map<String,dynamic> json){
      return new FetchData(
        title: json['title'],
        description: json['description'],
        imageUrl: json['user_photo'],
        id:json['id']
      );
    }


}