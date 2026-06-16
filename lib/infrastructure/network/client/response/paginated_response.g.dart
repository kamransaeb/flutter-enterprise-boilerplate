// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('PaginatedResponse', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['data', 'meta', 'links']);
  final val = PaginatedResponse<T>(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>).map(fromJsonT).toList(),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => PaginationMeta.fromJson(v as Map<String, dynamic>),
    ),
    links: $checkedConvert(
      'links',
      (v) => v == null
          ? null
          : PaginationLinks.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': instance.data.map(toJsonT).toList(),
  'meta': instance.meta.toJson(),
  'links': instance.links?.toJson(),
};

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginationMeta',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'current_page',
            'per_page',
            'total',
            'total_pages',
            'from',
            'to',
            'has_more',
          ],
        );
        final val = PaginationMeta(
          currentPage: $checkedConvert(
            'current_page',
            (v) => (v as num).toInt(),
          ),
          perPage: $checkedConvert('per_page', (v) => (v as num).toInt()),
          total: $checkedConvert('total', (v) => (v as num).toInt()),
          totalPages: $checkedConvert('total_pages', (v) => (v as num).toInt()),
          from: $checkedConvert('from', (v) => (v as num?)?.toInt()),
          to: $checkedConvert('to', (v) => (v as num?)?.toInt()),
          hasMore: $checkedConvert('has_more', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentPage': 'current_page',
        'perPage': 'per_page',
        'totalPages': 'total_pages',
        'hasMore': 'has_more',
      },
    );

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
      'from': instance.from,
      'to': instance.to,
      'has_more': instance.hasMore,
    };

PaginationLinks _$PaginationLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaginationLinks', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['first', 'last', 'prev', 'next']);
      final val = PaginationLinks(
        first: $checkedConvert('first', (v) => v as String?),
        last: $checkedConvert('last', (v) => v as String?),
        prev: $checkedConvert('prev', (v) => v as String?),
        next: $checkedConvert('next', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PaginationLinksToJson(PaginationLinks instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };
