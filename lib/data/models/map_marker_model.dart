import 'package:slate/domain/entities/map_item.dart';

class MapItemModel extends MapItem {
  const MapItemModel({
    required super.markerId,
    required super.type,
    required super.title,
    required super.position,
  });
}
