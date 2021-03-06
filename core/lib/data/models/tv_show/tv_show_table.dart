import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TVShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TVShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVShowTable.fromEntity(TVShowDetail tvShow) => TVShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory TVShowTable.fromMap(Map<String, dynamic> map) => TVShowTable(
        id: map["id"],
        name: map["name"],
        posterPath: map["posterPath"],
        overview: map["overview"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TVShow toEntity() => TVShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
