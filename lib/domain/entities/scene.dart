import 'package:equatable/equatable.dart';

class Scene extends Equatable {
  final String title;
  final int id; // scene id
  final int movieId;
  final String imageUrl;

  const Scene({
    required this.movieId,
    required this.title,
    required this.id,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id];
}
