// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penjualan_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPenjualanModelCollection on Isar {
  IsarCollection<PenjualanModel> get penjualanModels => this.collection();
}

const PenjualanModelSchema = CollectionSchema(
  name: r'PenjualanModel',
  id: -8600692590387439898,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'diskon': PropertySchema(
      id: 1,
      name: r'diskon',
      type: IsarType.double,
    ),
    r'kasir': PropertySchema(
      id: 2,
      name: r'kasir',
      type: IsarType.long,
    ),
    r'keterangan': PropertySchema(
      id: 3,
      name: r'keterangan',
      type: IsarType.string,
    ),
    r'pembeli': PropertySchema(
      id: 4,
      name: r'pembeli',
      type: IsarType.long,
    ),
    r'totalHarga': PropertySchema(
      id: 5,
      name: r'totalHarga',
      type: IsarType.double,
    ),
    r'totalItem': PropertySchema(
      id: 6,
      name: r'totalItem',
      type: IsarType.long,
    )
  },
  estimateSize: _penjualanModelEstimateSize,
  serialize: _penjualanModelSerialize,
  deserialize: _penjualanModelDeserialize,
  deserializeProp: _penjualanModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'items': LinkSchema(
      id: -3395604233004221325,
      name: r'items',
      target: r'ItemModel',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _penjualanModelGetId,
  getLinks: _penjualanModelGetLinks,
  attach: _penjualanModelAttach,
  version: '3.1.0+1',
);

int _penjualanModelEstimateSize(
  PenjualanModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.keterangan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _penjualanModelSerialize(
  PenjualanModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDouble(offsets[1], object.diskon);
  writer.writeLong(offsets[2], object.kasir);
  writer.writeString(offsets[3], object.keterangan);
  writer.writeLong(offsets[4], object.pembeli);
  writer.writeDouble(offsets[5], object.totalHarga);
  writer.writeLong(offsets[6], object.totalItem);
}

PenjualanModel _penjualanModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PenjualanModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.diskon = reader.readDouble(offsets[1]);
  object.id = id;
  object.kasir = reader.readLong(offsets[2]);
  object.keterangan = reader.readStringOrNull(offsets[3]);
  object.pembeli = reader.readLongOrNull(offsets[4]);
  object.totalHarga = reader.readDouble(offsets[5]);
  object.totalItem = reader.readLong(offsets[6]);
  return object;
}

P _penjualanModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _penjualanModelGetId(PenjualanModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _penjualanModelGetLinks(PenjualanModel object) {
  return [object.items];
}

void _penjualanModelAttach(
    IsarCollection<dynamic> col, Id id, PenjualanModel object) {
  object.id = id;
  object.items.attach(col, col.isar.collection<ItemModel>(), r'items', id);
}

extension PenjualanModelQueryWhereSort
    on QueryBuilder<PenjualanModel, PenjualanModel, QWhere> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PenjualanModelQueryWhere
    on QueryBuilder<PenjualanModel, PenjualanModel, QWhereClause> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PenjualanModelQueryFilter
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      diskonEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diskon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      diskonGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diskon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      diskonLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diskon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      diskonBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diskon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      kasirEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kasir',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      kasirGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kasir',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      kasirLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kasir',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      kasirBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kasir',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'keterangan',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'keterangan',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keterangan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keterangan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keterangan',
        value: '',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      keteranganIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keterangan',
        value: '',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pembeli',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pembeli',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pembeli',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pembeli',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pembeli',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      pembeliBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pembeli',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalHargaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalHarga',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalHargaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalHarga',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalHargaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalHarga',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalHargaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalHarga',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalItem',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalItem',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalItem',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PenjualanModelQueryObject
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {}

extension PenjualanModelQueryLinks
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition> items(
      FilterQuery<ItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'items');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, true, length, true);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, 0, true);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, false, 999999, true);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', 0, true, length, include);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'items', length, include, 999999, true);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'items', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PenjualanModelQuerySortBy
    on QueryBuilder<PenjualanModel, PenjualanModel, QSortBy> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByDiskon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diskon', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByDiskonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diskon', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByKasir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kasir', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByKasirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kasir', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByKeterangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByKeteranganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByPembeli() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pembeli', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByPembeliDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pembeli', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByTotalHarga() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHarga', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByTotalHargaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHarga', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> sortByTotalItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalItem', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      sortByTotalItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalItem', Sort.desc);
    });
  }
}

extension PenjualanModelQuerySortThenBy
    on QueryBuilder<PenjualanModel, PenjualanModel, QSortThenBy> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByDiskon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diskon', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByDiskonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diskon', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByKasir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kasir', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByKasirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kasir', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByKeterangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByKeteranganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByPembeli() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pembeli', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByPembeliDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pembeli', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByTotalHarga() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHarga', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByTotalHargaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHarga', Sort.desc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy> thenByTotalItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalItem', Sort.asc);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterSortBy>
      thenByTotalItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalItem', Sort.desc);
    });
  }
}

extension PenjualanModelQueryWhereDistinct
    on QueryBuilder<PenjualanModel, PenjualanModel, QDistinct> {
  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct> distinctByDiskon() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diskon');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct> distinctByKasir() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kasir');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct> distinctByKeterangan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keterangan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct> distinctByPembeli() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pembeli');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct>
      distinctByTotalHarga() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalHarga');
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QDistinct>
      distinctByTotalItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalItem');
    });
  }
}

extension PenjualanModelQueryProperty
    on QueryBuilder<PenjualanModel, PenjualanModel, QQueryProperty> {
  QueryBuilder<PenjualanModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PenjualanModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PenjualanModel, double, QQueryOperations> diskonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diskon');
    });
  }

  QueryBuilder<PenjualanModel, int, QQueryOperations> kasirProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kasir');
    });
  }

  QueryBuilder<PenjualanModel, String?, QQueryOperations> keteranganProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keterangan');
    });
  }

  QueryBuilder<PenjualanModel, int?, QQueryOperations> pembeliProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pembeli');
    });
  }

  QueryBuilder<PenjualanModel, double, QQueryOperations> totalHargaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalHarga');
    });
  }

  QueryBuilder<PenjualanModel, int, QQueryOperations> totalItemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalItem');
    });
  }
}
