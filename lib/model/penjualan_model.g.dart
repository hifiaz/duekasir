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
      target: r'ItemData',
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
      type: IsarType.double,
    )
  },
  estimateSize: _penjualanModelEstimateSize,
  serialize: _penjualanModelSerialize,
  deserialize: _penjualanModelDeserialize,
  deserializeProp: _penjualanModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'ItemData': ItemDataSchema},
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
    final list = object.items;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ItemData]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += ItemDataSchema.estimateSize(value, offsets, allOffsets);
        }
      }
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
  writer.writeObjectList<ItemData>(
    offsets[2],
    allOffsets,
    ItemDataSchema.serialize,
    object.items,
  );
  writer.writeLong(offsets[3], object.kasir);
  writer.writeString(offsets[4], object.keterangan);
  writer.writeLong(offsets[5], object.pembeli);
  writer.writeDouble(offsets[6], object.totalHarga);
  writer.writeDouble(offsets[7], object.totalItem);
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
  object.items = reader.readObjectList<ItemData>(
    offsets[2],
    ItemDataSchema.deserialize,
    allOffsets,
    ItemData(),
  );
  object.kasir = reader.readLong(offsets[3]);
  object.keterangan = reader.readStringOrNull(offsets[4]);
  object.pembeli = reader.readLongOrNull(offsets[5]);
  object.totalHarga = reader.readDouble(offsets[6]);
  object.totalItem = reader.readDouble(offsets[7]);
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
      return (reader.readObjectList<ItemData>(
        offset,
        ItemDataSchema.deserialize,
        allOffsets,
        ItemData(),
      )) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _penjualanModelGetId(PenjualanModel object) {
  return object.id;
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
      itemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'items',
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'items',
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
      totalItemEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalItem',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalItem',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalItem',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      totalItemBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PenjualanModelQueryObject
    on QueryBuilder<PenjualanModel, PenjualanModel, QFilterCondition> {
  QueryBuilder<PenjualanModel, PenjualanModel, QAfterFilterCondition>
      itemsElement(FilterQuery<ItemData> q) {
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

  QueryBuilder<PenjualanModel, List<ItemData>?, QQueryOperations>
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

  QueryBuilder<PenjualanModel, double, QQueryOperations> totalItemProperty() {
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

const ItemDataSchema = Schema(
  name: r'ItemData',
  id: 4439479512583442687,
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
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deskripsi': PropertySchema(
      id: 3,
      name: r'deskripsi',
      type: IsarType.string,
    ),
    r'diskonPersen': PropertySchema(
      id: 4,
      name: r'diskonPersen',
      type: IsarType.double,
    ),
    r'hargaDasar': PropertySchema(
      id: 5,
      name: r'hargaDasar',
      type: IsarType.double,
    ),
    r'hargaJual': PropertySchema(
      id: 6,
      name: r'hargaJual',
      type: IsarType.double,
    ),
    r'hargaJualPersen': PropertySchema(
      id: 7,
      name: r'hargaJualPersen',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 8,
      name: r'id',
      type: IsarType.long,
    ),
    r'isHargaJualPersen': PropertySchema(
      id: 9,
      name: r'isHargaJualPersen',
      type: IsarType.bool,
    ),
    r'jumlahBarang': PropertySchema(
      id: 10,
      name: r'jumlahBarang',
      type: IsarType.long,
    ),
    r'nama': PropertySchema(
      id: 11,
      name: r'nama',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 12,
      name: r'quantity',
      type: IsarType.long,
    )
  },
  estimateSize: _itemDataEstimateSize,
  serialize: _itemDataSerialize,
  deserialize: _itemDataDeserialize,
  deserializeProp: _itemDataDeserializeProp,
);

int _itemDataEstimateSize(
  ItemData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.deskripsi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nama.length * 3;
  return bytesCount;
}

void _itemDataSerialize(
  ItemData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.barangKeluar);
  writer.writeDateTime(offsets[1], object.barangMasuk);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.deskripsi);
  writer.writeDouble(offsets[4], object.diskonPersen);
  writer.writeDouble(offsets[5], object.hargaDasar);
  writer.writeDouble(offsets[6], object.hargaJual);
  writer.writeDouble(offsets[7], object.hargaJualPersen);
  writer.writeLong(offsets[8], object.id);
  writer.writeBool(offsets[9], object.isHargaJualPersen);
  writer.writeLong(offsets[10], object.jumlahBarang);
  writer.writeString(offsets[11], object.nama);
  writer.writeLong(offsets[12], object.quantity);
}

ItemData _itemDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemData();
  object.barangKeluar = reader.readDateTimeOrNull(offsets[0]);
  object.barangMasuk = reader.readDateTimeOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.deskripsi = reader.readStringOrNull(offsets[3]);
  object.diskonPersen = reader.readDoubleOrNull(offsets[4]);
  object.hargaDasar = reader.readDouble(offsets[5]);
  object.hargaJual = reader.readDouble(offsets[6]);
  object.hargaJualPersen = reader.readDoubleOrNull(offsets[7]);
  object.id = reader.readLong(offsets[8]);
  object.isHargaJualPersen = reader.readBool(offsets[9]);
  object.jumlahBarang = reader.readLong(offsets[10]);
  object.nama = reader.readString(offsets[11]);
  object.quantity = reader.readLong(offsets[12]);
  return object;
}

P _itemDataDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ItemDataQueryFilter
    on QueryBuilder<ItemData, ItemData, QFilterCondition> {
  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangKeluarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barangKeluar',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      barangKeluarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barangKeluar',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangKeluarEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barangKeluar',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangKeluarLessThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangKeluarBetween(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangMasukIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barangMasuk',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      barangMasukIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barangMasuk',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangMasukEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barangMasuk',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangMasukLessThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> barangMasukBetween(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deskripsi',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deskripsi',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiEqualTo(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiGreaterThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiLessThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiBetween(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiStartsWith(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiEndsWith(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deskripsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> deskripsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      deskripsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> diskonPersenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diskonPersen',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      diskonPersenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diskonPersen',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> diskonPersenEqualTo(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> diskonPersenLessThan(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> diskonPersenBetween(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaDasarEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hargaDasar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaDasarGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hargaDasar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaDasarLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hargaDasar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaDasarBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hargaDasar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaJualEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hargaJual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaJualGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hargaJual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaJualLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hargaJual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> hargaJualBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hargaJual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      hargaJualPersenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hargaJualPersen',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      hargaJualPersenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hargaJualPersen',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> idGreaterThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> idLessThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      isHargaJualPersenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHargaJualPersen',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> jumlahBarangEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jumlahBarang',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition>
      jumlahBarangGreaterThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> jumlahBarangLessThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> jumlahBarangBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaEqualTo(
    String value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaGreaterThan(
    String value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaLessThan(
    String value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaBetween(
    String lower,
    String upper, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaStartsWith(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaEndsWith(
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nama',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> namaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> quantityEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> quantityGreaterThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> quantityLessThan(
    int value, {
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

  QueryBuilder<ItemData, ItemData, QAfterFilterCondition> quantityBetween(
    int lower,
    int upper, {
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
}

extension ItemDataQueryObject
    on QueryBuilder<ItemData, ItemData, QFilterCondition> {}
