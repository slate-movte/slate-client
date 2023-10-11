// ignore_for_file: constant_identifier_names

enum Images {
  APP_LOGO(path: 'lib/assets/images/slate_logo.png'),
  FILM_ICON(path: 'lib/assets/images/film.png'),
  FOOD_ICON(path: 'lib/assets/images/food.png'),
  SITE_ICON(path: 'lib/assets/images/flag.png'),
  ACCOM_ICON(path: 'lib/assets/images/building.png');

  const Images({required this.path});

  final String path;
}
