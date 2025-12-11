import 'profile.dart';

class Match {
  final String id;
  final String userA;
  final String userB;
  final DateTime createdAt;
  final Profile? otherUser;

  Match({
    required this.id,
    required this.userA,
    required this.userB,
    required this.createdAt,
    this.otherUser,
  });

  factory Match.fromJson(Map<String, dynamic> json, {Profile? otherUser}) {
    return Match(
      id: json['id']?.toString() ?? '',
      userA: json['user_a']?.toString() ?? '',
      userB: json['user_b']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      otherUser: otherUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_a': userA,
      'user_b': userB,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Match copyWith({
    String? id,
    String? userA,
    String? userB,
    DateTime? createdAt,
    Profile? otherUser,
  }) {
    return Match(
      id: id ?? this.id,
      userA: userA ?? this.userA,
      userB: userB ?? this.userB,
      createdAt: createdAt ?? this.createdAt,
      otherUser: otherUser ?? this.otherUser,
    );
  }
}
