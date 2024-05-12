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
    r'items': PropertySchema(
      id: 2,
      name: r'items',
      type: IsarType.objectList,
      target: r'ProductItemModel',
    ),
    r'kasir': PropertySchema(
      id: 3,
      name: r'kasir',
      type: IsarType.long,
    ),
    r'keterangan': PropertySchema(
      id: 4,
      name: r'keterangan',
      type: IsarType.string,
    ),
    r'pembeli': PropertySchema(
      id: 5,
      name: r'pembeli',
      type: IsarType.long,
    ),
    r'totalHarga': PropertySchema(
      id: 6,
      name: r'totalHarga',
      type: IsarType.double,
    ),
    r'totalItem': PropertySchema(
      id: 7,
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
  links: {},
  embeddedSchemas: {r'ProductItemModel': ProductItemModelSchema},
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
  bytesCount += 3 + object.items.length * 3;
  {
    final offsets = allOffsets[ProductItemModel]!;
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount +=
          ProductItemModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
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
  writer.writeObjectList<ProductItemModel>(
    offsets[2],
    allOffsets,
    ProductItemModelSchema.serialize,
    object.items,
  );
  writer.writeLong(offsets[3], object.kasir);
  writer.writeString(offsets[4], object.keterangan);
  writer.writeLong(offsets[5], object.pembeli);
  writer.writeDouble(offsets[6], object.totalHarga);
  writer.writeLong(offsets[7], object.totalItem);
}

PenjualanModel _penjualanModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PenjualanModel(
    createdAt: reader.readDateTime(offsets[0]),
    diskon: reader.readDouble(offsets[1]),
    id: id,
    items: reader.readObjectList<ProductItemModel>(
          offsets[2],
          ProductItemModelSchema.deserialize,
          allOffsets,
          ProductItemModel(),
        ) ??
        [],
    kasir: reader.readLong(offsets[3]),
    keterangan: reader.readStringOrNull(offsets[4]),
    pembeli: reader.readLongOrNull(offsets[5]),
    totalHarga: reader.readDouble(offsets[6]),
    totalItem: reader.readLong(offsets[7]),
  );
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
      return (reader.readObjectList<ProductItemModel>(
            offset,
            ProductItemModelSchema.deserialize,
            allOffsets,
            ProductItemModel(),
          ) ??
          []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _penjualanModelGetId(PenjualanModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _penjualanModelGetLinks(PenjualanModel object) {
  return [];
}

void _penjualanModelAttach(
    IsarCollection<dynamic> col, Id id, PenjualanModel object) {
  object.id = id;
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

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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
    Id? value, {
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
    Id? lower,
    Id? upper, {
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
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
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
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsElement(FilterQuery<ProductItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}

extension PenjualanModelQueryLinks
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {}

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

  QueryBuilder<PenjualanModel, List<ProductItemModel>, QQueryOperations>
      itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
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

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProductItemModelSchema = Schema(
  name: r'ProductItemModel',
  id: 7456034504976285148,
  properties: {
    r'barangKeluar': PropertySchema(
      id: 0,
      name: r'barangKeluar',
      type: IsarType.dateTime,
    ),
    r'barangMasuk': PropertySchema(
      id: 1,
      name: r'barangMasuk',
      type: IsarType.dateTime,
    ),
    r'code': PropertySchema(
      id: 2,
      name: r'code',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deskripsi': PropertySchema(
      id: 4,
      name: r'deskripsi',
      type: IsarType.string,
    ),
    r'diskonPersen': PropertySchema(
      id: 5,
      name: r'diskonPersen',
      type: IsarType.double,
    ),
    r'hargaDasar': PropertySchema(
      id: 6,
      name: r'hargaDasar',
      type: IsarType.long,
    ),
    r'hargaJual': PropertySchema(
      id: 7,
      name: r'hargaJual',
      type: IsarType.long,
    ),
    r'hargaJualPersen': PropertySchema(
      id: 8,
      name: r'hargaJualPersen',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 9,
      name: r'id',
      type: IsarType.long,
    ),
    r'isHargaJualPersen': PropertySchema(
      id: 10,
      name: r'isHargaJualPersen',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 11,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'jumlahBarang': PropertySchema(
      id: 12,
      name: r'jumlahBarang',
      type: IsarType.long,
    ),
    r'nama': PropertySchema(
      id: 13,
      name: r'nama',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 14,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'ukuran': PropertySchema(
      id: 15,
      name: r'ukuran',
      type: IsarType.string,
    )
  },
  estimateSize: _productItemModelEstimateSize,
  serialize: _productItemModelSerialize,
  deserialize: _productItemModelDeserialize,
  deserializeProp: _productItemModelDeserializeProp,
);

int _productItemModelEstimateSize(
  ProductItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.code;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deskripsi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nama;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ukuran;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _productItemModelSerialize(
  ProductItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.barangKeluar);
  writer.writeDateTime(offsets[1], object.barangMasuk);
  writer.writeString(offsets[2], object.code);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.deskripsi);
  writer.writeDouble(offsets[5], object.diskonPersen);
  writer.writeLong(offsets[6], object.hargaDasar);
  writer.writeLong(offsets[7], object.hargaJual);
  writer.writeDouble(offsets[8], object.hargaJualPersen);
  writer.writeLong(offsets[9], object.id);
  writer.writeBool(offsets[10], object.isHargaJualPersen);
  writer.writeBool(offsets[11], object.isSynced);
  writer.writeLong(offsets[12], object.jumlahBarang);
  writer.writeString(offsets[13], object.nama);
  writer.writeLong(offsets[14], object.quantity);
  writer.writeString(offsets[15], object.ukuran);
}

ProductItemModel _productItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductItemModel(
    barangKeluar: reader.readDateTimeOrNull(offsets[0]),
    barangMasuk: reader.readDateTimeOrNull(offsets[1]),
    code: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readDateTimeOrNull(offsets[3]),
    deskripsi: reader.readStringOrNull(offsets[4]),
    diskonPersen: reader.readDoubleOrNull(offsets[5]),
    hargaDasar: reader.readLongOrNull(offsets[6]),
    hargaJual: reader.readLongOrNull(offsets[7]),
    hargaJualPersen: reader.readDoubleOrNull(offsets[8]),
    id: reader.readLongOrNull(offsets[9]),
    isHargaJualPersen: reader.readBoolOrNull(offsets[10]),
    isSynced: reader.readBoolOrNull(offsets[11]),
    jumlahBarang: reader.readLongOrNull(offsets[12]),
    nama: reader.readStringOrNull(offsets[13]),
    quantity: reader.readLongOrNull(offsets[14]),
    ukuran: reader.readStringOrNull(offsets[15]),
  );
  return object;
}

P _productItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ProductItemModelQueryFilter
    on QueryBuilder<ProductItemModel, ProductItemModel, QFilterCondition> {
  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barangKeluar',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barangKeluar',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barangKeluar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barangKeluar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barangKeluar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangKeluarBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barangKeluar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barangMasuk',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barangMasuk',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barangMasuk',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barangMasuk',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barangMasuk',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      barangMasukBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barangMasuk',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deskripsi',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deskripsi',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deskripsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deskripsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      deskripsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diskonPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diskonPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diskonPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diskonPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diskonPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      diskonPersenBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diskonPersen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hargaDasar',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hargaDasar',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hargaDasar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hargaDasar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hargaDasar',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaDasarBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hargaDasar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hargaJual',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hargaJual',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hargaJual',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hargaJual',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hargaJual',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hargaJual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hargaJualPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hargaJualPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hargaJualPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hargaJualPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hargaJualPersen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      hargaJualPersenBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hargaJualPersen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idGreaterThan(
    int? value, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idLessThan(
    int? value, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      idBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isHargaJualPersenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isHargaJualPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isHargaJualPersenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isHargaJualPersen',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isHargaJualPersenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHargaJualPersen',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isSyncedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSynced',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isSyncedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSynced',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      isSyncedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jumlahBarang',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jumlahBarang',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jumlahBarang',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jumlahBarang',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jumlahBarang',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      jumlahBarangBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jumlahBarang',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nama',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nama',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nama',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nama',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      namaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      quantityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ukuran',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ukuran',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ukuran',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ukuran',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ukuran',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ukuran',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductItemModel, ProductItemModel, QAfterFilterCondition>
      ukuranIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ukuran',
        value: '',
      ));
    });
  }
}

extension ProductItemModelQueryObject
    on QueryBuilder<ProductItemModel, ProductItemModel, QFilterCondition> {}
