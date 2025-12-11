class Swipe {
  final String id;
  final String swiperId;
  final String targetId;
  final bool isLike;
  final DateTime createdAt;

  Swipe({
    required this.id,
    required this.swiperId,
    required this.targetId,
    required this.isLike,
    required this.createdAt,
  });

  factory Swipe.fromJson(Map<String, dynamic> json) {
    return Swipe(
      id: json['id'] as String,
      swiperId: json['swiper_id'] as String,
      targetId: json['target_id'] as String,
      isLike: json['is_like'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'swiper_id': swiperId,
      'target_id': targetId,
      'is_like': isLike,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

