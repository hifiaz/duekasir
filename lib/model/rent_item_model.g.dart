// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_item_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRentItemModelCollection on Isar {
  IsarCollection<RentItemModel> get rentItemModels => this.collection();
}

const RentItemModelSchema = CollectionSchema(
  name: r'RentItemModel',
  id: 312457036859512384,
  properties: {
    r'code': PropertySchema(
      id: 0,
      name: r'code',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isSynced': PropertySchema(
      id: 2,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'jumlahBarang': PropertySchema(
      id: 3,
      name: r'jumlahBarang',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'note': PropertySchema(
      id: 5,
      name: r'note',
      type: IsarType.string,
    ),
    r'rentOneMonth': PropertySchema(
      id: 6,
      name: r'rentOneMonth',
      type: IsarType.long,
    ),
    r'rentOneWeek': PropertySchema(
      id: 7,
      name: r'rentOneWeek',
      type: IsarType.long,
    ),
    r'rentThreeDay': PropertySchema(
      id: 8,
      name: r'rentThreeDay',
      type: IsarType.long,
    )
  },
  estimateSize: _rentItemModelEstimateSize,
  serialize: _rentItemModelSerialize,
  deserialize: _rentItemModelDeserialize,
  deserializeProp: _rentItemModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _rentItemModelGetId,
  getLinks: _rentItemModelGetLinks,
  attach: _rentItemModelAttach,
  version: '3.1.0+1',
);

int _rentItemModelEstimateSize(
  RentItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.code.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _rentItemModelSerialize(
  RentItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.code);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.isSynced);
  writer.writeLong(offsets[3], object.jumlahBarang);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.note);
  writer.writeLong(offsets[6], object.rentOneMonth);
  writer.writeLong(offsets[7], object.rentOneWeek);
  writer.writeLong(offsets[8], object.rentThreeDay);
}

RentItemModel _rentItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RentItemModel(
    code: reader.readString(offsets[0]),
    createdAt: reader.readDateTimeOrNull(offsets[1]),
    id: id,
    isSynced: reader.readBoolOrNull(offsets[2]) ?? true,
    jumlahBarang: reader.readLong(offsets[3]),
    name: reader.readString(offsets[4]),
    note: reader.readStringOrNull(offsets[5]),
    rentOneMonth: reader.readLong(offsets[6]),
    rentOneWeek: reader.readLong(offsets[7]),
    rentThreeDay: reader.readLong(offsets[8]),
  );
  return object;
}

P _rentItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rentItemModelGetId(RentItemModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _rentItemModelGetLinks(RentItemModel object) {
  return [];
}

void _rentItemModelAttach(
    IsarCollection<dynamic> col, Id id, RentItemModel object) {
  object.id = id;
}

extension RentItemModelQueryWhereSort
    on QueryBuilder<RentItemModel, RentItemModel, QWhere> {
  QueryBuilder<RentItemModel, RentItemModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RentItemModelQueryWhere
    on QueryBuilder<RentItemModel, RentItemModel, QWhereClause> {
  QueryBuilder<RentItemModel, RentItemModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterWhereClause> idBetween(
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

extension RentItemModelQueryFilter
    on QueryBuilder<RentItemModel, RentItemModel, QFilterCondition> {
  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> codeEqualTo(
    String value, {
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      codeGreaterThan(
    String value, {
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      codeLessThan(
    String value, {
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> codeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> codeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      jumlahBarangEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jumlahBarang',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      jumlahBarangLessThan(
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      jumlahBarangBetween(
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

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneMonthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rentOneMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneMonthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rentOneMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneMonthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rentOneMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneMonthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rentOneMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneWeekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rentOneWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneWeekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rentOneWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneWeekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rentOneWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentOneWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rentOneWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentThreeDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rentThreeDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentThreeDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rentThreeDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentThreeDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rentThreeDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterFilterCondition>
      rentThreeDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rentThreeDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RentItemModelQueryObject
    on QueryBuilder<RentItemModel, RentItemModel, QFilterCondition> {}

extension RentItemModelQueryLinks
    on QueryBuilder<RentItemModel, RentItemModel, QFilterCondition> {}

extension RentItemModelQuerySortBy
    on QueryBuilder<RentItemModel, RentItemModel, QSortBy> {
  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByJumlahBarang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahBarang', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByJumlahBarangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahBarang', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByRentOneMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneMonth', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByRentOneMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneMonth', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> sortByRentOneWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneWeek', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByRentOneWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneWeek', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByRentThreeDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentThreeDay', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      sortByRentThreeDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentThreeDay', Sort.desc);
    });
  }
}

extension RentItemModelQuerySortThenBy
    on QueryBuilder<RentItemModel, RentItemModel, QSortThenBy> {
  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByJumlahBarang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahBarang', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByJumlahBarangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahBarang', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByRentOneMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneMonth', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByRentOneMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneMonth', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy> thenByRentOneWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneWeek', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByRentOneWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentOneWeek', Sort.desc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByRentThreeDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentThreeDay', Sort.asc);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QAfterSortBy>
      thenByRentThreeDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rentThreeDay', Sort.desc);
    });
  }
}

extension RentItemModelQueryWhereDistinct
    on QueryBuilder<RentItemModel, RentItemModel, QDistinct> {
  QueryBuilder<RentItemModel, RentItemModel, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct>
      distinctByJumlahBarang() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jumlahBarang');
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct>
      distinctByRentOneMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rentOneMonth');
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct>
      distinctByRentOneWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rentOneWeek');
    });
  }

  QueryBuilder<RentItemModel, RentItemModel, QDistinct>
      distinctByRentThreeDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rentThreeDay');
    });
  }
}

extension RentItemModelQueryProperty
    on QueryBuilder<RentItemModel, RentItemModel, QQueryProperty> {
  QueryBuilder<RentItemModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RentItemModel, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<RentItemModel, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RentItemModel, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<RentItemModel, int, QQueryOperations> jumlahBarangProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jumlahBarang');
    });
  }

  QueryBuilder<RentItemModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RentItemModel, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<RentItemModel, int, QQueryOperations> rentOneMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rentOneMonth');
    });
  }

  QueryBuilder<RentItemModel, int, QQueryOperations> rentOneWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rentOneWeek');
    });
  }

  QueryBuilder<RentItemModel, int, QQueryOperations> rentThreeDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rentThreeDay');
    });
  }
}
