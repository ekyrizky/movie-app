library core;

// datasource
export 'data/datasources/local/db/database_helper.dart';
export 'data/datasources/local/movie_local_data_source.dart';
export 'data/datasources/local/tv_show_local_data_source.dart';
export 'data/datasources/remote/movie_remote_data_source.dart';
export 'data/datasources/remote/tv_show_remote_data_source.dart';

// models
export 'data/models/movie/movie_detail_model.dart';
export 'data/models/movie/movie_model.dart';
export 'data/models/movie/movie_response.dart';
export 'data/models/movie/movie_table.dart';
export 'data/models/genre_model.dart';
export 'data/models/season_model.dart';
export 'data/models/tv_show/tv_show_detail_model.dart';
export 'data/models/tv_show/tv_show_model.dart';
export 'data/models/tv_show/tv_show_response.dart';
export 'data/models/tv_show/tv_show_table.dart';
export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_show_repository_impl.dart';

// entities
export 'domain/entities/genre.dart';
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/entities/season.dart';
export 'domain/entities/tv_show.dart';
export 'domain/entities/tv_show_detail.dart';

// repository
export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_show_repository.dart';

// movie usecase
export 'domain/usecases/movie/get_movie_detail.dart';
export 'domain/usecases/movie/get_movie_recommendations.dart';
export 'domain/usecases/movie/get_now_playing_movies.dart';
export 'domain/usecases/movie/get_popular_movies.dart';
export 'domain/usecases/movie/get_top_rated_movies.dart';
export 'domain/usecases/movie/get_watchlist_movies.dart';
export 'domain/usecases/movie/get_watchlist_status.dart';
export 'domain/usecases/movie/remove_watchlist_movie.dart';
export 'domain/usecases/movie/save_watchlist_movie.dart';
export 'domain/usecases/movie/search_movies.dart';

// tv show usecase
export 'domain/usecases/tv_show/get_now_playing_tv_shows.dart';
export 'domain/usecases/tv_show/get_popular_tv_shows.dart';
export 'domain/usecases/tv_show/get_top_rated_tv_shows.dart';
export 'domain/usecases/tv_show/get_tv_show_detail.dart';
export 'domain/usecases/tv_show/get_tv_show_recommendations.dart';
export 'domain/usecases/tv_show/get_watchlist_status.dart';
export 'domain/usecases/tv_show/get_watchlist_tv_shows.dart';
export 'domain/usecases/tv_show/remove_watchlist_tv_show.dart';
export 'domain/usecases/tv_show/save_watchlist_tv_show.dart';
export 'domain/usecases/tv_show/search_tv_shows.dart';

// widgets
export 'presentation/widgets/card_list.dart';
export 'presentation/widgets/empty_search.dart';
export 'presentation/widgets/poster_image.dart';
export 'presentation/widgets/sub_heading.dart';

// style
export 'styles/colors.dart';
export 'styles/text_styles.dart';

// utils
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/routes.dart';
export 'utils/ssl/http_ssl.dart';
export 'utils/ssl/shared.dart';
export 'utils/state_enum.dart';
export 'utils/string_formatting.dart';
export 'utils/utils.dart';
