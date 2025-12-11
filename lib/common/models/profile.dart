class Profile {
  final String id;
  final String userId;
  final String displayName;
  final String? bio;
  final String gender;
  final String interestedIn;
  final int age;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.displayName,
    this.bio,
    required this.gender,
    required this.interestedIn,
    required this.age,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      displayName: json['display_name'] as String,
      bio: json['bio'] as String?,
      gender: json['gender'] as String,
      interestedIn: json['interested_in'] as String,
      age: json['age'] as int,
      photoUrl: json['photo_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'display_name': displayName,
      'bio': bio,
      'gender': gender,
      'interested_in': interestedIn,
      'age': age,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Profile copyWith({
    String? id,
    String? userId,
    String? displayName,
    String? bio,
    String? gender,
    String? interestedIn,
    int? age,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      interestedIn: interestedIn ?? this.interestedIn,
      age: age ?? this.age,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

