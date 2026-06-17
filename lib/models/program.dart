class Instructor {
  final String name;
  final String title;
  final String bio;

  Instructor({
    required this.name,
    required this.title,
    required this.bio,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
    );
  }
}

class Review {
  final String name;
  final String comment;
  final int stars;

  Review({
    required this.name,
    required this.comment,
    required this.stars,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'] ?? '',
      comment: json['comment'] ?? '',
      stars: json['stars'] ?? 0,
    );
  }
}

class Program {
  final String title;
  final String description;
  final String duration;
  final String level;
  final String rating;
  final String reviews;
  final Instructor? instructor;
  final List<Review> reviewsList;

  Program({
    required this.title,
    required this.description,
    required this.duration,
    required this.level,
    required this.rating,
    required this.reviews,
    this.instructor,
    this.reviewsList = const [],
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    var rList = json['reviewsList'] as List? ?? [];
    List<Review> parsedReviews = rList.map((r) => Review.fromJson(r)).toList();

    return Program(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
      level: json['level'] ?? '',
      rating: json['rating'] ?? '',
      reviews: json['reviews'] ?? '',
      instructor: json['instructor'] != null ? Instructor.fromJson(json['instructor']) : null,
      reviewsList: parsedReviews,
    );
  }
}
