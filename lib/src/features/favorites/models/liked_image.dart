import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreImage {
  final DateTime createdAt;
  final String url;
  final int likeCount;

  FirestoreImage({
    required this.createdAt,
    required this.url,
    required this.likeCount,
  });

  factory FirestoreImage.fromMap(Map<String, dynamic> map) {
    return FirestoreImage(
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      url: map['url'] as String? ?? '',
      likeCount: map['likeCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'url': url,
      'likeCount': likeCount,
    };
  }

  FirestoreImage copyWith({
    DateTime? createdAt,
    String? url,
    int? likeCount,
  }) {
    return FirestoreImage(
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}
