class PostEntity {
  final int userId;
  final String userName;
  final String userProfile;
  final String postTime;
  final String title;
  final String description;
  final String imagePath;

  PostEntity({
    required this.userId,
    required this.userName,
    required this.userProfile,
    required this.postTime,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  // Method to convert PostEntity to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userProfile': userProfile,
      'postTime': postTime,
      'postTitle': title,
      'postDescription': description,
      'postImage': imagePath,
    };
  }

  // Method to convert a Map (retrieved from Firebase) to a PostEntity
  factory PostEntity.fromMap(Map<dynamic, dynamic> map) {
    return PostEntity(
      userId: map['userId'] as int,
      userName: map['userName'] as String,
      userProfile: map['userProfile'] as String,
      postTime: map['postTime'] as String,
      title: map['postTitle'] as String,
      description: map['postDescription'] as String,
      imagePath: map['postImage'] as String,
    );
  }
}
