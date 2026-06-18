// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedExamMeta =
      const VerificationMeta('selectedExam');
  @override
  late final GeneratedColumn<String> selectedExam = GeneratedColumn<String>(
      'selected_exam', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uiLanguageMeta =
      const VerificationMeta('uiLanguage');
  @override
  late final GeneratedColumn<String> uiLanguage = GeneratedColumn<String>(
      'ui_language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dailyCapacityMinutesMeta =
      const VerificationMeta('dailyCapacityMinutes');
  @override
  late final GeneratedColumn<int> dailyCapacityMinutes = GeneratedColumn<int>(
      'daily_capacity_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weakDomainsMeta =
      const VerificationMeta('weakDomains');
  @override
  late final GeneratedColumn<String> weakDomains = GeneratedColumn<String>(
      'weak_domains', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        phoneNumber,
        selectedExam,
        uiLanguage,
        dailyCapacityMinutes,
        weakDomains,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('selected_exam')) {
      context.handle(
          _selectedExamMeta,
          selectedExam.isAcceptableOrUnknown(
              data['selected_exam']!, _selectedExamMeta));
    }
    if (data.containsKey('ui_language')) {
      context.handle(
          _uiLanguageMeta,
          uiLanguage.isAcceptableOrUnknown(
              data['ui_language']!, _uiLanguageMeta));
    }
    if (data.containsKey('daily_capacity_minutes')) {
      context.handle(
          _dailyCapacityMinutesMeta,
          dailyCapacityMinutes.isAcceptableOrUnknown(
              data['daily_capacity_minutes']!, _dailyCapacityMinutesMeta));
    }
    if (data.containsKey('weak_domains')) {
      context.handle(
          _weakDomainsMeta,
          weakDomains.isAcceptableOrUnknown(
              data['weak_domains']!, _weakDomainsMeta));
    } else if (isInserting) {
      context.missing(_weakDomainsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      selectedExam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_exam']),
      uiLanguage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ui_language']),
      dailyCapacityMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}daily_capacity_minutes']),
      weakDomains: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weak_domains'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String? phoneNumber;
  final String? selectedExam;
  final String? uiLanguage;
  final int? dailyCapacityMinutes;
  final String weakDomains;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User(
      {required this.id,
      this.phoneNumber,
      this.selectedExam,
      this.uiLanguage,
      this.dailyCapacityMinutes,
      required this.weakDomains,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || selectedExam != null) {
      map['selected_exam'] = Variable<String>(selectedExam);
    }
    if (!nullToAbsent || uiLanguage != null) {
      map['ui_language'] = Variable<String>(uiLanguage);
    }
    if (!nullToAbsent || dailyCapacityMinutes != null) {
      map['daily_capacity_minutes'] = Variable<int>(dailyCapacityMinutes);
    }
    map['weak_domains'] = Variable<String>(weakDomains);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      selectedExam: selectedExam == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedExam),
      uiLanguage: uiLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(uiLanguage),
      dailyCapacityMinutes: dailyCapacityMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyCapacityMinutes),
      weakDomains: Value(weakDomains),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      selectedExam: serializer.fromJson<String?>(json['selectedExam']),
      uiLanguage: serializer.fromJson<String?>(json['uiLanguage']),
      dailyCapacityMinutes:
          serializer.fromJson<int?>(json['dailyCapacityMinutes']),
      weakDomains: serializer.fromJson<String>(json['weakDomains']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'selectedExam': serializer.toJson<String?>(selectedExam),
      'uiLanguage': serializer.toJson<String?>(uiLanguage),
      'dailyCapacityMinutes': serializer.toJson<int?>(dailyCapacityMinutes),
      'weakDomains': serializer.toJson<String>(weakDomains),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith(
          {String? id,
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> selectedExam = const Value.absent(),
          Value<String?> uiLanguage = const Value.absent(),
          Value<int?> dailyCapacityMinutes = const Value.absent(),
          String? weakDomains,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      User(
        id: id ?? this.id,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        selectedExam:
            selectedExam.present ? selectedExam.value : this.selectedExam,
        uiLanguage: uiLanguage.present ? uiLanguage.value : this.uiLanguage,
        dailyCapacityMinutes: dailyCapacityMinutes.present
            ? dailyCapacityMinutes.value
            : this.dailyCapacityMinutes,
        weakDomains: weakDomains ?? this.weakDomains,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      selectedExam: data.selectedExam.present
          ? data.selectedExam.value
          : this.selectedExam,
      uiLanguage:
          data.uiLanguage.present ? data.uiLanguage.value : this.uiLanguage,
      dailyCapacityMinutes: data.dailyCapacityMinutes.present
          ? data.dailyCapacityMinutes.value
          : this.dailyCapacityMinutes,
      weakDomains:
          data.weakDomains.present ? data.weakDomains.value : this.weakDomains,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('selectedExam: $selectedExam, ')
          ..write('uiLanguage: $uiLanguage, ')
          ..write('dailyCapacityMinutes: $dailyCapacityMinutes, ')
          ..write('weakDomains: $weakDomains, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, phoneNumber, selectedExam, uiLanguage,
      dailyCapacityMinutes, weakDomains, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.selectedExam == this.selectedExam &&
          other.uiLanguage == this.uiLanguage &&
          other.dailyCapacityMinutes == this.dailyCapacityMinutes &&
          other.weakDomains == this.weakDomains &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String?> phoneNumber;
  final Value<String?> selectedExam;
  final Value<String?> uiLanguage;
  final Value<int?> dailyCapacityMinutes;
  final Value<String> weakDomains;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.selectedExam = const Value.absent(),
    this.uiLanguage = const Value.absent(),
    this.dailyCapacityMinutes = const Value.absent(),
    this.weakDomains = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.phoneNumber = const Value.absent(),
    this.selectedExam = const Value.absent(),
    this.uiLanguage = const Value.absent(),
    this.dailyCapacityMinutes = const Value.absent(),
    required String weakDomains,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        weakDomains = Value(weakDomains),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? selectedExam,
    Expression<String>? uiLanguage,
    Expression<int>? dailyCapacityMinutes,
    Expression<String>? weakDomains,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (selectedExam != null) 'selected_exam': selectedExam,
      if (uiLanguage != null) 'ui_language': uiLanguage,
      if (dailyCapacityMinutes != null)
        'daily_capacity_minutes': dailyCapacityMinutes,
      if (weakDomains != null) 'weak_domains': weakDomains,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? phoneNumber,
      Value<String?>? selectedExam,
      Value<String?>? uiLanguage,
      Value<int?>? dailyCapacityMinutes,
      Value<String>? weakDomains,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedExam: selectedExam ?? this.selectedExam,
      uiLanguage: uiLanguage ?? this.uiLanguage,
      dailyCapacityMinutes: dailyCapacityMinutes ?? this.dailyCapacityMinutes,
      weakDomains: weakDomains ?? this.weakDomains,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (selectedExam.present) {
      map['selected_exam'] = Variable<String>(selectedExam.value);
    }
    if (uiLanguage.present) {
      map['ui_language'] = Variable<String>(uiLanguage.value);
    }
    if (dailyCapacityMinutes.present) {
      map['daily_capacity_minutes'] = Variable<int>(dailyCapacityMinutes.value);
    }
    if (weakDomains.present) {
      map['weak_domains'] = Variable<String>(weakDomains.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('selectedExam: $selectedExam, ')
          ..write('uiLanguage: $uiLanguage, ')
          ..write('dailyCapacityMinutes: $dailyCapacityMinutes, ')
          ..write('weakDomains: $weakDomains, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaxonomyNodesTable extends TaxonomyNodes
    with TableInfo<$TaxonomyNodesTable, TaxonomyNode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxonomyNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, parentId, level];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taxonomy_nodes';
  @override
  VerificationContext validateIntegrity(Insertable<TaxonomyNode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaxonomyNode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaxonomyNode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
    );
  }

  @override
  $TaxonomyNodesTable createAlias(String alias) {
    return $TaxonomyNodesTable(attachedDatabase, alias);
  }
}

class TaxonomyNode extends DataClass implements Insertable<TaxonomyNode> {
  final String id;
  final String name;
  final String? parentId;
  final int level;
  const TaxonomyNode(
      {required this.id,
      required this.name,
      this.parentId,
      required this.level});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['level'] = Variable<int>(level);
    return map;
  }

  TaxonomyNodesCompanion toCompanion(bool nullToAbsent) {
    return TaxonomyNodesCompanion(
      id: Value(id),
      name: Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      level: Value(level),
    );
  }

  factory TaxonomyNode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxonomyNode(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<String?>(parentId),
      'level': serializer.toJson<int>(level),
    };
  }

  TaxonomyNode copyWith(
          {String? id,
          String? name,
          Value<String?> parentId = const Value.absent(),
          int? level}) =>
      TaxonomyNode(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId.present ? parentId.value : this.parentId,
        level: level ?? this.level,
      );
  TaxonomyNode copyWithCompanion(TaxonomyNodesCompanion data) {
    return TaxonomyNode(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaxonomyNode(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, parentId, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxonomyNode &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentId == this.parentId &&
          other.level == this.level);
}

class TaxonomyNodesCompanion extends UpdateCompanion<TaxonomyNode> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> parentId;
  final Value<int> level;
  final Value<int> rowid;
  const TaxonomyNodesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaxonomyNodesCompanion.insert({
    required String id,
    required String name,
    this.parentId = const Value.absent(),
    required int level,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        level = Value(level);
  static Insertable<TaxonomyNode> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? parentId,
    Expression<int>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaxonomyNodesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? parentId,
      Value<int>? level,
      Value<int>? rowid}) {
    return TaxonomyNodesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxonomyNodesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taxonomyIdMeta =
      const VerificationMeta('taxonomyId');
  @override
  late final GeneratedColumn<String> taxonomyId = GeneratedColumn<String>(
      'taxonomy_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionEnMeta =
      const VerificationMeta('questionEn');
  @override
  late final GeneratedColumn<String> questionEn = GeneratedColumn<String>(
      'question_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionHiMeta =
      const VerificationMeta('questionHi');
  @override
  late final GeneratedColumn<String> questionHi = GeneratedColumn<String>(
      'question_hi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsEnMeta =
      const VerificationMeta('optionsEn');
  @override
  late final GeneratedColumn<String> optionsEn = GeneratedColumn<String>(
      'options_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsHiMeta =
      const VerificationMeta('optionsHi');
  @override
  late final GeneratedColumn<String> optionsHi = GeneratedColumn<String>(
      'options_hi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctOptionMeta =
      const VerificationMeta('correctOption');
  @override
  late final GeneratedColumn<int> correctOption = GeneratedColumn<int>(
      'correct_option', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _difficultyLevelMeta =
      const VerificationMeta('difficultyLevel');
  @override
  late final GeneratedColumn<String> difficultyLevel = GeneratedColumn<String>(
      'difficulty_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _explanationEnMeta =
      const VerificationMeta('explanationEn');
  @override
  late final GeneratedColumn<String> explanationEn = GeneratedColumn<String>(
      'explanation_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _explanationHiMeta =
      const VerificationMeta('explanationHi');
  @override
  late final GeneratedColumn<String> explanationHi = GeneratedColumn<String>(
      'explanation_hi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _explanationHinglishMeta =
      const VerificationMeta('explanationHinglish');
  @override
  late final GeneratedColumn<String> explanationHinglish =
      GeneratedColumn<String>('explanation_hinglish', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortcutFormulaNoteMeta =
      const VerificationMeta('shortcutFormulaNote');
  @override
  late final GeneratedColumn<String> shortcutFormulaNote =
      GeneratedColumn<String>('shortcut_formula_note', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commonMistakeNoteMeta =
      const VerificationMeta('commonMistakeNote');
  @override
  late final GeneratedColumn<String> commonMistakeNote =
      GeneratedColumn<String>('common_mistake_note', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taxonomyId,
        questionEn,
        questionHi,
        optionsEn,
        optionsHi,
        correctOption,
        difficultyLevel,
        explanationEn,
        explanationHi,
        explanationHinglish,
        shortcutFormulaNote,
        commonMistakeNote,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('taxonomy_id')) {
      context.handle(
          _taxonomyIdMeta,
          taxonomyId.isAcceptableOrUnknown(
              data['taxonomy_id']!, _taxonomyIdMeta));
    } else if (isInserting) {
      context.missing(_taxonomyIdMeta);
    }
    if (data.containsKey('question_en')) {
      context.handle(
          _questionEnMeta,
          questionEn.isAcceptableOrUnknown(
              data['question_en']!, _questionEnMeta));
    } else if (isInserting) {
      context.missing(_questionEnMeta);
    }
    if (data.containsKey('question_hi')) {
      context.handle(
          _questionHiMeta,
          questionHi.isAcceptableOrUnknown(
              data['question_hi']!, _questionHiMeta));
    } else if (isInserting) {
      context.missing(_questionHiMeta);
    }
    if (data.containsKey('options_en')) {
      context.handle(_optionsEnMeta,
          optionsEn.isAcceptableOrUnknown(data['options_en']!, _optionsEnMeta));
    } else if (isInserting) {
      context.missing(_optionsEnMeta);
    }
    if (data.containsKey('options_hi')) {
      context.handle(_optionsHiMeta,
          optionsHi.isAcceptableOrUnknown(data['options_hi']!, _optionsHiMeta));
    } else if (isInserting) {
      context.missing(_optionsHiMeta);
    }
    if (data.containsKey('correct_option')) {
      context.handle(
          _correctOptionMeta,
          correctOption.isAcceptableOrUnknown(
              data['correct_option']!, _correctOptionMeta));
    } else if (isInserting) {
      context.missing(_correctOptionMeta);
    }
    if (data.containsKey('difficulty_level')) {
      context.handle(
          _difficultyLevelMeta,
          difficultyLevel.isAcceptableOrUnknown(
              data['difficulty_level']!, _difficultyLevelMeta));
    } else if (isInserting) {
      context.missing(_difficultyLevelMeta);
    }
    if (data.containsKey('explanation_en')) {
      context.handle(
          _explanationEnMeta,
          explanationEn.isAcceptableOrUnknown(
              data['explanation_en']!, _explanationEnMeta));
    } else if (isInserting) {
      context.missing(_explanationEnMeta);
    }
    if (data.containsKey('explanation_hi')) {
      context.handle(
          _explanationHiMeta,
          explanationHi.isAcceptableOrUnknown(
              data['explanation_hi']!, _explanationHiMeta));
    } else if (isInserting) {
      context.missing(_explanationHiMeta);
    }
    if (data.containsKey('explanation_hinglish')) {
      context.handle(
          _explanationHinglishMeta,
          explanationHinglish.isAcceptableOrUnknown(
              data['explanation_hinglish']!, _explanationHinglishMeta));
    } else if (isInserting) {
      context.missing(_explanationHinglishMeta);
    }
    if (data.containsKey('shortcut_formula_note')) {
      context.handle(
          _shortcutFormulaNoteMeta,
          shortcutFormulaNote.isAcceptableOrUnknown(
              data['shortcut_formula_note']!, _shortcutFormulaNoteMeta));
    }
    if (data.containsKey('common_mistake_note')) {
      context.handle(
          _commonMistakeNoteMeta,
          commonMistakeNote.isAcceptableOrUnknown(
              data['common_mistake_note']!, _commonMistakeNoteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taxonomyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taxonomy_id'])!,
      questionEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_en'])!,
      questionHi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_hi'])!,
      optionsEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options_en'])!,
      optionsHi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options_hi'])!,
      correctOption: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_option'])!,
      difficultyLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}difficulty_level'])!,
      explanationEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation_en'])!,
      explanationHi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation_hi'])!,
      explanationHinglish: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}explanation_hinglish'])!,
      shortcutFormulaNote: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}shortcut_formula_note']),
      commonMistakeNote: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}common_mistake_note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final String id;
  final String taxonomyId;
  final String questionEn;
  final String questionHi;
  final String optionsEn;
  final String optionsHi;
  final int correctOption;
  final String difficultyLevel;
  final String explanationEn;
  final String explanationHi;
  final String explanationHinglish;
  final String? shortcutFormulaNote;
  final String? commonMistakeNote;
  final DateTime createdAt;
  const Question(
      {required this.id,
      required this.taxonomyId,
      required this.questionEn,
      required this.questionHi,
      required this.optionsEn,
      required this.optionsHi,
      required this.correctOption,
      required this.difficultyLevel,
      required this.explanationEn,
      required this.explanationHi,
      required this.explanationHinglish,
      this.shortcutFormulaNote,
      this.commonMistakeNote,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['taxonomy_id'] = Variable<String>(taxonomyId);
    map['question_en'] = Variable<String>(questionEn);
    map['question_hi'] = Variable<String>(questionHi);
    map['options_en'] = Variable<String>(optionsEn);
    map['options_hi'] = Variable<String>(optionsHi);
    map['correct_option'] = Variable<int>(correctOption);
    map['difficulty_level'] = Variable<String>(difficultyLevel);
    map['explanation_en'] = Variable<String>(explanationEn);
    map['explanation_hi'] = Variable<String>(explanationHi);
    map['explanation_hinglish'] = Variable<String>(explanationHinglish);
    if (!nullToAbsent || shortcutFormulaNote != null) {
      map['shortcut_formula_note'] = Variable<String>(shortcutFormulaNote);
    }
    if (!nullToAbsent || commonMistakeNote != null) {
      map['common_mistake_note'] = Variable<String>(commonMistakeNote);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      taxonomyId: Value(taxonomyId),
      questionEn: Value(questionEn),
      questionHi: Value(questionHi),
      optionsEn: Value(optionsEn),
      optionsHi: Value(optionsHi),
      correctOption: Value(correctOption),
      difficultyLevel: Value(difficultyLevel),
      explanationEn: Value(explanationEn),
      explanationHi: Value(explanationHi),
      explanationHinglish: Value(explanationHinglish),
      shortcutFormulaNote: shortcutFormulaNote == null && nullToAbsent
          ? const Value.absent()
          : Value(shortcutFormulaNote),
      commonMistakeNote: commonMistakeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(commonMistakeNote),
      createdAt: Value(createdAt),
    );
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<String>(json['id']),
      taxonomyId: serializer.fromJson<String>(json['taxonomyId']),
      questionEn: serializer.fromJson<String>(json['questionEn']),
      questionHi: serializer.fromJson<String>(json['questionHi']),
      optionsEn: serializer.fromJson<String>(json['optionsEn']),
      optionsHi: serializer.fromJson<String>(json['optionsHi']),
      correctOption: serializer.fromJson<int>(json['correctOption']),
      difficultyLevel: serializer.fromJson<String>(json['difficultyLevel']),
      explanationEn: serializer.fromJson<String>(json['explanationEn']),
      explanationHi: serializer.fromJson<String>(json['explanationHi']),
      explanationHinglish:
          serializer.fromJson<String>(json['explanationHinglish']),
      shortcutFormulaNote:
          serializer.fromJson<String?>(json['shortcutFormulaNote']),
      commonMistakeNote:
          serializer.fromJson<String?>(json['commonMistakeNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taxonomyId': serializer.toJson<String>(taxonomyId),
      'questionEn': serializer.toJson<String>(questionEn),
      'questionHi': serializer.toJson<String>(questionHi),
      'optionsEn': serializer.toJson<String>(optionsEn),
      'optionsHi': serializer.toJson<String>(optionsHi),
      'correctOption': serializer.toJson<int>(correctOption),
      'difficultyLevel': serializer.toJson<String>(difficultyLevel),
      'explanationEn': serializer.toJson<String>(explanationEn),
      'explanationHi': serializer.toJson<String>(explanationHi),
      'explanationHinglish': serializer.toJson<String>(explanationHinglish),
      'shortcutFormulaNote': serializer.toJson<String?>(shortcutFormulaNote),
      'commonMistakeNote': serializer.toJson<String?>(commonMistakeNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Question copyWith(
          {String? id,
          String? taxonomyId,
          String? questionEn,
          String? questionHi,
          String? optionsEn,
          String? optionsHi,
          int? correctOption,
          String? difficultyLevel,
          String? explanationEn,
          String? explanationHi,
          String? explanationHinglish,
          Value<String?> shortcutFormulaNote = const Value.absent(),
          Value<String?> commonMistakeNote = const Value.absent(),
          DateTime? createdAt}) =>
      Question(
        id: id ?? this.id,
        taxonomyId: taxonomyId ?? this.taxonomyId,
        questionEn: questionEn ?? this.questionEn,
        questionHi: questionHi ?? this.questionHi,
        optionsEn: optionsEn ?? this.optionsEn,
        optionsHi: optionsHi ?? this.optionsHi,
        correctOption: correctOption ?? this.correctOption,
        difficultyLevel: difficultyLevel ?? this.difficultyLevel,
        explanationEn: explanationEn ?? this.explanationEn,
        explanationHi: explanationHi ?? this.explanationHi,
        explanationHinglish: explanationHinglish ?? this.explanationHinglish,
        shortcutFormulaNote: shortcutFormulaNote.present
            ? shortcutFormulaNote.value
            : this.shortcutFormulaNote,
        commonMistakeNote: commonMistakeNote.present
            ? commonMistakeNote.value
            : this.commonMistakeNote,
        createdAt: createdAt ?? this.createdAt,
      );
  Question copyWithCompanion(QuestionsCompanion data) {
    return Question(
      id: data.id.present ? data.id.value : this.id,
      taxonomyId:
          data.taxonomyId.present ? data.taxonomyId.value : this.taxonomyId,
      questionEn:
          data.questionEn.present ? data.questionEn.value : this.questionEn,
      questionHi:
          data.questionHi.present ? data.questionHi.value : this.questionHi,
      optionsEn: data.optionsEn.present ? data.optionsEn.value : this.optionsEn,
      optionsHi: data.optionsHi.present ? data.optionsHi.value : this.optionsHi,
      correctOption: data.correctOption.present
          ? data.correctOption.value
          : this.correctOption,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      explanationEn: data.explanationEn.present
          ? data.explanationEn.value
          : this.explanationEn,
      explanationHi: data.explanationHi.present
          ? data.explanationHi.value
          : this.explanationHi,
      explanationHinglish: data.explanationHinglish.present
          ? data.explanationHinglish.value
          : this.explanationHinglish,
      shortcutFormulaNote: data.shortcutFormulaNote.present
          ? data.shortcutFormulaNote.value
          : this.shortcutFormulaNote,
      commonMistakeNote: data.commonMistakeNote.present
          ? data.commonMistakeNote.value
          : this.commonMistakeNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('taxonomyId: $taxonomyId, ')
          ..write('questionEn: $questionEn, ')
          ..write('questionHi: $questionHi, ')
          ..write('optionsEn: $optionsEn, ')
          ..write('optionsHi: $optionsHi, ')
          ..write('correctOption: $correctOption, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('explanationEn: $explanationEn, ')
          ..write('explanationHi: $explanationHi, ')
          ..write('explanationHinglish: $explanationHinglish, ')
          ..write('shortcutFormulaNote: $shortcutFormulaNote, ')
          ..write('commonMistakeNote: $commonMistakeNote, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      taxonomyId,
      questionEn,
      questionHi,
      optionsEn,
      optionsHi,
      correctOption,
      difficultyLevel,
      explanationEn,
      explanationHi,
      explanationHinglish,
      shortcutFormulaNote,
      commonMistakeNote,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.taxonomyId == this.taxonomyId &&
          other.questionEn == this.questionEn &&
          other.questionHi == this.questionHi &&
          other.optionsEn == this.optionsEn &&
          other.optionsHi == this.optionsHi &&
          other.correctOption == this.correctOption &&
          other.difficultyLevel == this.difficultyLevel &&
          other.explanationEn == this.explanationEn &&
          other.explanationHi == this.explanationHi &&
          other.explanationHinglish == this.explanationHinglish &&
          other.shortcutFormulaNote == this.shortcutFormulaNote &&
          other.commonMistakeNote == this.commonMistakeNote &&
          other.createdAt == this.createdAt);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<String> id;
  final Value<String> taxonomyId;
  final Value<String> questionEn;
  final Value<String> questionHi;
  final Value<String> optionsEn;
  final Value<String> optionsHi;
  final Value<int> correctOption;
  final Value<String> difficultyLevel;
  final Value<String> explanationEn;
  final Value<String> explanationHi;
  final Value<String> explanationHinglish;
  final Value<String?> shortcutFormulaNote;
  final Value<String?> commonMistakeNote;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.taxonomyId = const Value.absent(),
    this.questionEn = const Value.absent(),
    this.questionHi = const Value.absent(),
    this.optionsEn = const Value.absent(),
    this.optionsHi = const Value.absent(),
    this.correctOption = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.explanationEn = const Value.absent(),
    this.explanationHi = const Value.absent(),
    this.explanationHinglish = const Value.absent(),
    this.shortcutFormulaNote = const Value.absent(),
    this.commonMistakeNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    required String taxonomyId,
    required String questionEn,
    required String questionHi,
    required String optionsEn,
    required String optionsHi,
    required int correctOption,
    required String difficultyLevel,
    required String explanationEn,
    required String explanationHi,
    required String explanationHinglish,
    this.shortcutFormulaNote = const Value.absent(),
    this.commonMistakeNote = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taxonomyId = Value(taxonomyId),
        questionEn = Value(questionEn),
        questionHi = Value(questionHi),
        optionsEn = Value(optionsEn),
        optionsHi = Value(optionsHi),
        correctOption = Value(correctOption),
        difficultyLevel = Value(difficultyLevel),
        explanationEn = Value(explanationEn),
        explanationHi = Value(explanationHi),
        explanationHinglish = Value(explanationHinglish),
        createdAt = Value(createdAt);
  static Insertable<Question> custom({
    Expression<String>? id,
    Expression<String>? taxonomyId,
    Expression<String>? questionEn,
    Expression<String>? questionHi,
    Expression<String>? optionsEn,
    Expression<String>? optionsHi,
    Expression<int>? correctOption,
    Expression<String>? difficultyLevel,
    Expression<String>? explanationEn,
    Expression<String>? explanationHi,
    Expression<String>? explanationHinglish,
    Expression<String>? shortcutFormulaNote,
    Expression<String>? commonMistakeNote,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taxonomyId != null) 'taxonomy_id': taxonomyId,
      if (questionEn != null) 'question_en': questionEn,
      if (questionHi != null) 'question_hi': questionHi,
      if (optionsEn != null) 'options_en': optionsEn,
      if (optionsHi != null) 'options_hi': optionsHi,
      if (correctOption != null) 'correct_option': correctOption,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (explanationEn != null) 'explanation_en': explanationEn,
      if (explanationHi != null) 'explanation_hi': explanationHi,
      if (explanationHinglish != null)
        'explanation_hinglish': explanationHinglish,
      if (shortcutFormulaNote != null)
        'shortcut_formula_note': shortcutFormulaNote,
      if (commonMistakeNote != null) 'common_mistake_note': commonMistakeNote,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? taxonomyId,
      Value<String>? questionEn,
      Value<String>? questionHi,
      Value<String>? optionsEn,
      Value<String>? optionsHi,
      Value<int>? correctOption,
      Value<String>? difficultyLevel,
      Value<String>? explanationEn,
      Value<String>? explanationHi,
      Value<String>? explanationHinglish,
      Value<String?>? shortcutFormulaNote,
      Value<String?>? commonMistakeNote,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      taxonomyId: taxonomyId ?? this.taxonomyId,
      questionEn: questionEn ?? this.questionEn,
      questionHi: questionHi ?? this.questionHi,
      optionsEn: optionsEn ?? this.optionsEn,
      optionsHi: optionsHi ?? this.optionsHi,
      correctOption: correctOption ?? this.correctOption,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      explanationEn: explanationEn ?? this.explanationEn,
      explanationHi: explanationHi ?? this.explanationHi,
      explanationHinglish: explanationHinglish ?? this.explanationHinglish,
      shortcutFormulaNote: shortcutFormulaNote ?? this.shortcutFormulaNote,
      commonMistakeNote: commonMistakeNote ?? this.commonMistakeNote,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taxonomyId.present) {
      map['taxonomy_id'] = Variable<String>(taxonomyId.value);
    }
    if (questionEn.present) {
      map['question_en'] = Variable<String>(questionEn.value);
    }
    if (questionHi.present) {
      map['question_hi'] = Variable<String>(questionHi.value);
    }
    if (optionsEn.present) {
      map['options_en'] = Variable<String>(optionsEn.value);
    }
    if (optionsHi.present) {
      map['options_hi'] = Variable<String>(optionsHi.value);
    }
    if (correctOption.present) {
      map['correct_option'] = Variable<int>(correctOption.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<String>(difficultyLevel.value);
    }
    if (explanationEn.present) {
      map['explanation_en'] = Variable<String>(explanationEn.value);
    }
    if (explanationHi.present) {
      map['explanation_hi'] = Variable<String>(explanationHi.value);
    }
    if (explanationHinglish.present) {
      map['explanation_hinglish'] = Variable<String>(explanationHinglish.value);
    }
    if (shortcutFormulaNote.present) {
      map['shortcut_formula_note'] =
          Variable<String>(shortcutFormulaNote.value);
    }
    if (commonMistakeNote.present) {
      map['common_mistake_note'] = Variable<String>(commonMistakeNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('taxonomyId: $taxonomyId, ')
          ..write('questionEn: $questionEn, ')
          ..write('questionHi: $questionHi, ')
          ..write('optionsEn: $optionsEn, ')
          ..write('optionsHi: $optionsHi, ')
          ..write('correctOption: $correctOption, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('explanationEn: $explanationEn, ')
          ..write('explanationHi: $explanationHi, ')
          ..write('explanationHinglish: $explanationHinglish, ')
          ..write('shortcutFormulaNote: $shortcutFormulaNote, ')
          ..write('commonMistakeNote: $commonMistakeNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TestsTable extends Tests with TableInfo<$TestsTable, Test> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testTypeMeta =
      const VerificationMeta('testType');
  @override
  late final GeneratedColumn<String> testType = GeneratedColumn<String>(
      'test_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalQuestionsMeta =
      const VerificationMeta('totalQuestions');
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
      'total_questions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeLimitMinutesMeta =
      const VerificationMeta('timeLimitMinutes');
  @override
  late final GeneratedColumn<int> timeLimitMinutes = GeneratedColumn<int>(
      'time_limit_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        testType,
        totalQuestions,
        timeLimitMinutes,
        startedAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tests';
  @override
  VerificationContext validateIntegrity(Insertable<Test> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('test_type')) {
      context.handle(_testTypeMeta,
          testType.isAcceptableOrUnknown(data['test_type']!, _testTypeMeta));
    } else if (isInserting) {
      context.missing(_testTypeMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
          _totalQuestionsMeta,
          totalQuestions.isAcceptableOrUnknown(
              data['total_questions']!, _totalQuestionsMeta));
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('time_limit_minutes')) {
      context.handle(
          _timeLimitMinutesMeta,
          timeLimitMinutes.isAcceptableOrUnknown(
              data['time_limit_minutes']!, _timeLimitMinutesMeta));
    } else if (isInserting) {
      context.missing(_timeLimitMinutesMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Test map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Test(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      testType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_type'])!,
      totalQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_questions'])!,
      timeLimitMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}time_limit_minutes'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $TestsTable createAlias(String alias) {
    return $TestsTable(attachedDatabase, alias);
  }
}

class Test extends DataClass implements Insertable<Test> {
  final String id;
  final String userId;
  final String testType;
  final int totalQuestions;
  final int timeLimitMinutes;
  final DateTime startedAt;
  final DateTime? completedAt;
  const Test(
      {required this.id,
      required this.userId,
      required this.testType,
      required this.totalQuestions,
      required this.timeLimitMinutes,
      required this.startedAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['test_type'] = Variable<String>(testType);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['time_limit_minutes'] = Variable<int>(timeLimitMinutes);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TestsCompanion toCompanion(bool nullToAbsent) {
    return TestsCompanion(
      id: Value(id),
      userId: Value(userId),
      testType: Value(testType),
      totalQuestions: Value(totalQuestions),
      timeLimitMinutes: Value(timeLimitMinutes),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Test.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Test(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      testType: serializer.fromJson<String>(json['testType']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      timeLimitMinutes: serializer.fromJson<int>(json['timeLimitMinutes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'testType': serializer.toJson<String>(testType),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'timeLimitMinutes': serializer.toJson<int>(timeLimitMinutes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Test copyWith(
          {String? id,
          String? userId,
          String? testType,
          int? totalQuestions,
          int? timeLimitMinutes,
          DateTime? startedAt,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Test(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        testType: testType ?? this.testType,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        timeLimitMinutes: timeLimitMinutes ?? this.timeLimitMinutes,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Test copyWithCompanion(TestsCompanion data) {
    return Test(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      testType: data.testType.present ? data.testType.value : this.testType,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      timeLimitMinutes: data.timeLimitMinutes.present
          ? data.timeLimitMinutes.value
          : this.timeLimitMinutes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Test(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('testType: $testType, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('timeLimitMinutes: $timeLimitMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, testType, totalQuestions,
      timeLimitMinutes, startedAt, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Test &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.testType == this.testType &&
          other.totalQuestions == this.totalQuestions &&
          other.timeLimitMinutes == this.timeLimitMinutes &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt);
}

class TestsCompanion extends UpdateCompanion<Test> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> testType;
  final Value<int> totalQuestions;
  final Value<int> timeLimitMinutes;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const TestsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.testType = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.timeLimitMinutes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestsCompanion.insert({
    required String id,
    required String userId,
    required String testType,
    required int totalQuestions,
    required int timeLimitMinutes,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        testType = Value(testType),
        totalQuestions = Value(totalQuestions),
        timeLimitMinutes = Value(timeLimitMinutes),
        startedAt = Value(startedAt);
  static Insertable<Test> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? testType,
    Expression<int>? totalQuestions,
    Expression<int>? timeLimitMinutes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (testType != null) 'test_type': testType,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (timeLimitMinutes != null) 'time_limit_minutes': timeLimitMinutes,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? testType,
      Value<int>? totalQuestions,
      Value<int>? timeLimitMinutes,
      Value<DateTime>? startedAt,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return TestsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      testType: testType ?? this.testType,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      timeLimitMinutes: timeLimitMinutes ?? this.timeLimitMinutes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (testType.present) {
      map['test_type'] = Variable<String>(testType.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (timeLimitMinutes.present) {
      map['time_limit_minutes'] = Variable<int>(timeLimitMinutes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('testType: $testType, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('timeLimitMinutes: $timeLimitMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TestQuestionMapTable extends TestQuestionMap
    with TableInfo<$TestQuestionMapTable, TestQuestionMapData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestQuestionMapTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
      'test_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceOrderMeta =
      const VerificationMeta('sequenceOrder');
  @override
  late final GeneratedColumn<int> sequenceOrder = GeneratedColumn<int>(
      'sequence_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, testId, questionId, sequenceOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_question_map';
  @override
  VerificationContext validateIntegrity(
      Insertable<TestQuestionMapData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('sequence_order')) {
      context.handle(
          _sequenceOrderMeta,
          sequenceOrder.isAcceptableOrUnknown(
              data['sequence_order']!, _sequenceOrderMeta));
    } else if (isInserting) {
      context.missing(_sequenceOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestQuestionMapData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestQuestionMapData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      sequenceOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_order'])!,
    );
  }

  @override
  $TestQuestionMapTable createAlias(String alias) {
    return $TestQuestionMapTable(attachedDatabase, alias);
  }
}

class TestQuestionMapData extends DataClass
    implements Insertable<TestQuestionMapData> {
  final String id;
  final String testId;
  final String questionId;
  final int sequenceOrder;
  const TestQuestionMapData(
      {required this.id,
      required this.testId,
      required this.questionId,
      required this.sequenceOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['test_id'] = Variable<String>(testId);
    map['question_id'] = Variable<String>(questionId);
    map['sequence_order'] = Variable<int>(sequenceOrder);
    return map;
  }

  TestQuestionMapCompanion toCompanion(bool nullToAbsent) {
    return TestQuestionMapCompanion(
      id: Value(id),
      testId: Value(testId),
      questionId: Value(questionId),
      sequenceOrder: Value(sequenceOrder),
    );
  }

  factory TestQuestionMapData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestQuestionMapData(
      id: serializer.fromJson<String>(json['id']),
      testId: serializer.fromJson<String>(json['testId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      sequenceOrder: serializer.fromJson<int>(json['sequenceOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'testId': serializer.toJson<String>(testId),
      'questionId': serializer.toJson<String>(questionId),
      'sequenceOrder': serializer.toJson<int>(sequenceOrder),
    };
  }

  TestQuestionMapData copyWith(
          {String? id,
          String? testId,
          String? questionId,
          int? sequenceOrder}) =>
      TestQuestionMapData(
        id: id ?? this.id,
        testId: testId ?? this.testId,
        questionId: questionId ?? this.questionId,
        sequenceOrder: sequenceOrder ?? this.sequenceOrder,
      );
  TestQuestionMapData copyWithCompanion(TestQuestionMapCompanion data) {
    return TestQuestionMapData(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      sequenceOrder: data.sequenceOrder.present
          ? data.sequenceOrder.value
          : this.sequenceOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestQuestionMapData(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('questionId: $questionId, ')
          ..write('sequenceOrder: $sequenceOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, testId, questionId, sequenceOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestQuestionMapData &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.questionId == this.questionId &&
          other.sequenceOrder == this.sequenceOrder);
}

class TestQuestionMapCompanion extends UpdateCompanion<TestQuestionMapData> {
  final Value<String> id;
  final Value<String> testId;
  final Value<String> questionId;
  final Value<int> sequenceOrder;
  final Value<int> rowid;
  const TestQuestionMapCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.sequenceOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestQuestionMapCompanion.insert({
    required String id,
    required String testId,
    required String questionId,
    required int sequenceOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        testId = Value(testId),
        questionId = Value(questionId),
        sequenceOrder = Value(sequenceOrder);
  static Insertable<TestQuestionMapData> custom({
    Expression<String>? id,
    Expression<String>? testId,
    Expression<String>? questionId,
    Expression<int>? sequenceOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (questionId != null) 'question_id': questionId,
      if (sequenceOrder != null) 'sequence_order': sequenceOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestQuestionMapCompanion copyWith(
      {Value<String>? id,
      Value<String>? testId,
      Value<String>? questionId,
      Value<int>? sequenceOrder,
      Value<int>? rowid}) {
    return TestQuestionMapCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      questionId: questionId ?? this.questionId,
      sequenceOrder: sequenceOrder ?? this.sequenceOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (sequenceOrder.present) {
      map['sequence_order'] = Variable<int>(sequenceOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestQuestionMapCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('questionId: $questionId, ')
          ..write('sequenceOrder: $sequenceOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLedgerTable extends SyncLedger
    with TableInfo<$SyncLedgerTable, SyncLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientTimestampMeta =
      const VerificationMeta('clientTimestamp');
  @override
  late final GeneratedColumn<DateTime> clientTimestamp =
      GeneratedColumn<DateTime>('client_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _processedStatusMeta =
      const VerificationMeta('processedStatus');
  @override
  late final GeneratedColumn<bool> processedStatus = GeneratedColumn<bool>(
      'processed_status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("processed_status" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, eventType, payload, clientTimestamp, processedStatus, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_ledger';
  @override
  VerificationContext validateIntegrity(Insertable<SyncLedgerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('client_timestamp')) {
      context.handle(
          _clientTimestampMeta,
          clientTimestamp.isAcceptableOrUnknown(
              data['client_timestamp']!, _clientTimestampMeta));
    } else if (isInserting) {
      context.missing(_clientTimestampMeta);
    }
    if (data.containsKey('processed_status')) {
      context.handle(
          _processedStatusMeta,
          processedStatus.isAcceptableOrUnknown(
              data['processed_status']!, _processedStatusMeta));
    } else if (isInserting) {
      context.missing(_processedStatusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLedgerData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      clientTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_timestamp'])!,
      processedStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}processed_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncLedgerTable createAlias(String alias) {
    return $SyncLedgerTable(attachedDatabase, alias);
  }
}

class SyncLedgerData extends DataClass implements Insertable<SyncLedgerData> {
  final String id;
  final String eventType;
  final String payload;
  final DateTime clientTimestamp;
  final bool processedStatus;
  final DateTime createdAt;
  const SyncLedgerData(
      {required this.id,
      required this.eventType,
      required this.payload,
      required this.clientTimestamp,
      required this.processedStatus,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_type'] = Variable<String>(eventType);
    map['payload'] = Variable<String>(payload);
    map['client_timestamp'] = Variable<DateTime>(clientTimestamp);
    map['processed_status'] = Variable<bool>(processedStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncLedgerCompanion toCompanion(bool nullToAbsent) {
    return SyncLedgerCompanion(
      id: Value(id),
      eventType: Value(eventType),
      payload: Value(payload),
      clientTimestamp: Value(clientTimestamp),
      processedStatus: Value(processedStatus),
      createdAt: Value(createdAt),
    );
  }

  factory SyncLedgerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLedgerData(
      id: serializer.fromJson<String>(json['id']),
      eventType: serializer.fromJson<String>(json['eventType']),
      payload: serializer.fromJson<String>(json['payload']),
      clientTimestamp: serializer.fromJson<DateTime>(json['clientTimestamp']),
      processedStatus: serializer.fromJson<bool>(json['processedStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventType': serializer.toJson<String>(eventType),
      'payload': serializer.toJson<String>(payload),
      'clientTimestamp': serializer.toJson<DateTime>(clientTimestamp),
      'processedStatus': serializer.toJson<bool>(processedStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncLedgerData copyWith(
          {String? id,
          String? eventType,
          String? payload,
          DateTime? clientTimestamp,
          bool? processedStatus,
          DateTime? createdAt}) =>
      SyncLedgerData(
        id: id ?? this.id,
        eventType: eventType ?? this.eventType,
        payload: payload ?? this.payload,
        clientTimestamp: clientTimestamp ?? this.clientTimestamp,
        processedStatus: processedStatus ?? this.processedStatus,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncLedgerData copyWithCompanion(SyncLedgerCompanion data) {
    return SyncLedgerData(
      id: data.id.present ? data.id.value : this.id,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      payload: data.payload.present ? data.payload.value : this.payload,
      clientTimestamp: data.clientTimestamp.present
          ? data.clientTimestamp.value
          : this.clientTimestamp,
      processedStatus: data.processedStatus.present
          ? data.processedStatus.value
          : this.processedStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLedgerData(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('payload: $payload, ')
          ..write('clientTimestamp: $clientTimestamp, ')
          ..write('processedStatus: $processedStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, eventType, payload, clientTimestamp, processedStatus, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLedgerData &&
          other.id == this.id &&
          other.eventType == this.eventType &&
          other.payload == this.payload &&
          other.clientTimestamp == this.clientTimestamp &&
          other.processedStatus == this.processedStatus &&
          other.createdAt == this.createdAt);
}

class SyncLedgerCompanion extends UpdateCompanion<SyncLedgerData> {
  final Value<String> id;
  final Value<String> eventType;
  final Value<String> payload;
  final Value<DateTime> clientTimestamp;
  final Value<bool> processedStatus;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncLedgerCompanion({
    this.id = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payload = const Value.absent(),
    this.clientTimestamp = const Value.absent(),
    this.processedStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLedgerCompanion.insert({
    required String id,
    required String eventType,
    required String payload,
    required DateTime clientTimestamp,
    required bool processedStatus,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        eventType = Value(eventType),
        payload = Value(payload),
        clientTimestamp = Value(clientTimestamp),
        processedStatus = Value(processedStatus),
        createdAt = Value(createdAt);
  static Insertable<SyncLedgerData> custom({
    Expression<String>? id,
    Expression<String>? eventType,
    Expression<String>? payload,
    Expression<DateTime>? clientTimestamp,
    Expression<bool>? processedStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventType != null) 'event_type': eventType,
      if (payload != null) 'payload': payload,
      if (clientTimestamp != null) 'client_timestamp': clientTimestamp,
      if (processedStatus != null) 'processed_status': processedStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLedgerCompanion copyWith(
      {Value<String>? id,
      Value<String>? eventType,
      Value<String>? payload,
      Value<DateTime>? clientTimestamp,
      Value<bool>? processedStatus,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SyncLedgerCompanion(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      payload: payload ?? this.payload,
      clientTimestamp: clientTimestamp ?? this.clientTimestamp,
      processedStatus: processedStatus ?? this.processedStatus,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (clientTimestamp.present) {
      map['client_timestamp'] = Variable<DateTime>(clientTimestamp.value);
    }
    if (processedStatus.present) {
      map['processed_status'] = Variable<bool>(processedStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLedgerCompanion(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('payload: $payload, ')
          ..write('clientTimestamp: $clientTimestamp, ')
          ..write('processedStatus: $processedStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAttemptsTable extends UserAttempts
    with TableInfo<$UserAttemptsTable, UserAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
      'test_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _selectedOptionMeta =
      const VerificationMeta('selectedOption');
  @override
  late final GeneratedColumn<int> selectedOption = GeneratedColumn<int>(
      'selected_option', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _confidenceLevelMeta =
      const VerificationMeta('confidenceLevel');
  @override
  late final GeneratedColumn<String> confidenceLevel = GeneratedColumn<String>(
      'confidence_level', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
      'is_correct', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_correct" IN (0, 1))'));
  static const VerificationMeta _timeTakenSecondsMeta =
      const VerificationMeta('timeTakenSeconds');
  @override
  late final GeneratedColumn<int> timeTakenSeconds = GeneratedColumn<int>(
      'time_taken_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        testId,
        questionId,
        selectedOption,
        confidenceLevel,
        isCorrect,
        timeTakenSeconds,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_attempts';
  @override
  VerificationContext validateIntegrity(Insertable<UserAttempt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('selected_option')) {
      context.handle(
          _selectedOptionMeta,
          selectedOption.isAcceptableOrUnknown(
              data['selected_option']!, _selectedOptionMeta));
    }
    if (data.containsKey('confidence_level')) {
      context.handle(
          _confidenceLevelMeta,
          confidenceLevel.isAcceptableOrUnknown(
              data['confidence_level']!, _confidenceLevelMeta));
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    }
    if (data.containsKey('time_taken_seconds')) {
      context.handle(
          _timeTakenSecondsMeta,
          timeTakenSeconds.isAcceptableOrUnknown(
              data['time_taken_seconds']!, _timeTakenSecondsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAttempt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      selectedOption: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}selected_option']),
      confidenceLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}confidence_level']),
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_correct']),
      timeTakenSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_taken_seconds']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserAttemptsTable createAlias(String alias) {
    return $UserAttemptsTable(attachedDatabase, alias);
  }
}

class UserAttempt extends DataClass implements Insertable<UserAttempt> {
  final String id;
  final String userId;
  final String testId;
  final String questionId;
  final int? selectedOption;
  final String? confidenceLevel;
  final bool? isCorrect;
  final int? timeTakenSeconds;
  final DateTime createdAt;
  const UserAttempt(
      {required this.id,
      required this.userId,
      required this.testId,
      required this.questionId,
      this.selectedOption,
      this.confidenceLevel,
      this.isCorrect,
      this.timeTakenSeconds,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['test_id'] = Variable<String>(testId);
    map['question_id'] = Variable<String>(questionId);
    if (!nullToAbsent || selectedOption != null) {
      map['selected_option'] = Variable<int>(selectedOption);
    }
    if (!nullToAbsent || confidenceLevel != null) {
      map['confidence_level'] = Variable<String>(confidenceLevel);
    }
    if (!nullToAbsent || isCorrect != null) {
      map['is_correct'] = Variable<bool>(isCorrect);
    }
    if (!nullToAbsent || timeTakenSeconds != null) {
      map['time_taken_seconds'] = Variable<int>(timeTakenSeconds);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserAttemptsCompanion toCompanion(bool nullToAbsent) {
    return UserAttemptsCompanion(
      id: Value(id),
      userId: Value(userId),
      testId: Value(testId),
      questionId: Value(questionId),
      selectedOption: selectedOption == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedOption),
      confidenceLevel: confidenceLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(confidenceLevel),
      isCorrect: isCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(isCorrect),
      timeTakenSeconds: timeTakenSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(timeTakenSeconds),
      createdAt: Value(createdAt),
    );
  }

  factory UserAttempt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAttempt(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      testId: serializer.fromJson<String>(json['testId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      selectedOption: serializer.fromJson<int?>(json['selectedOption']),
      confidenceLevel: serializer.fromJson<String?>(json['confidenceLevel']),
      isCorrect: serializer.fromJson<bool?>(json['isCorrect']),
      timeTakenSeconds: serializer.fromJson<int?>(json['timeTakenSeconds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'testId': serializer.toJson<String>(testId),
      'questionId': serializer.toJson<String>(questionId),
      'selectedOption': serializer.toJson<int?>(selectedOption),
      'confidenceLevel': serializer.toJson<String?>(confidenceLevel),
      'isCorrect': serializer.toJson<bool?>(isCorrect),
      'timeTakenSeconds': serializer.toJson<int?>(timeTakenSeconds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserAttempt copyWith(
          {String? id,
          String? userId,
          String? testId,
          String? questionId,
          Value<int?> selectedOption = const Value.absent(),
          Value<String?> confidenceLevel = const Value.absent(),
          Value<bool?> isCorrect = const Value.absent(),
          Value<int?> timeTakenSeconds = const Value.absent(),
          DateTime? createdAt}) =>
      UserAttempt(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        testId: testId ?? this.testId,
        questionId: questionId ?? this.questionId,
        selectedOption:
            selectedOption.present ? selectedOption.value : this.selectedOption,
        confidenceLevel: confidenceLevel.present
            ? confidenceLevel.value
            : this.confidenceLevel,
        isCorrect: isCorrect.present ? isCorrect.value : this.isCorrect,
        timeTakenSeconds: timeTakenSeconds.present
            ? timeTakenSeconds.value
            : this.timeTakenSeconds,
        createdAt: createdAt ?? this.createdAt,
      );
  UserAttempt copyWithCompanion(UserAttemptsCompanion data) {
    return UserAttempt(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      testId: data.testId.present ? data.testId.value : this.testId,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      selectedOption: data.selectedOption.present
          ? data.selectedOption.value
          : this.selectedOption,
      confidenceLevel: data.confidenceLevel.present
          ? data.confidenceLevel.value
          : this.confidenceLevel,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      timeTakenSeconds: data.timeTakenSeconds.present
          ? data.timeTakenSeconds.value
          : this.timeTakenSeconds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAttempt(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('testId: $testId, ')
          ..write('questionId: $questionId, ')
          ..write('selectedOption: $selectedOption, ')
          ..write('confidenceLevel: $confidenceLevel, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, testId, questionId,
      selectedOption, confidenceLevel, isCorrect, timeTakenSeconds, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAttempt &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.testId == this.testId &&
          other.questionId == this.questionId &&
          other.selectedOption == this.selectedOption &&
          other.confidenceLevel == this.confidenceLevel &&
          other.isCorrect == this.isCorrect &&
          other.timeTakenSeconds == this.timeTakenSeconds &&
          other.createdAt == this.createdAt);
}

class UserAttemptsCompanion extends UpdateCompanion<UserAttempt> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> testId;
  final Value<String> questionId;
  final Value<int?> selectedOption;
  final Value<String?> confidenceLevel;
  final Value<bool?> isCorrect;
  final Value<int?> timeTakenSeconds;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserAttemptsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.testId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.selectedOption = const Value.absent(),
    this.confidenceLevel = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.timeTakenSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAttemptsCompanion.insert({
    required String id,
    required String userId,
    required String testId,
    required String questionId,
    this.selectedOption = const Value.absent(),
    this.confidenceLevel = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.timeTakenSeconds = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        testId = Value(testId),
        questionId = Value(questionId),
        createdAt = Value(createdAt);
  static Insertable<UserAttempt> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? testId,
    Expression<String>? questionId,
    Expression<int>? selectedOption,
    Expression<String>? confidenceLevel,
    Expression<bool>? isCorrect,
    Expression<int>? timeTakenSeconds,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (testId != null) 'test_id': testId,
      if (questionId != null) 'question_id': questionId,
      if (selectedOption != null) 'selected_option': selectedOption,
      if (confidenceLevel != null) 'confidence_level': confidenceLevel,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (timeTakenSeconds != null) 'time_taken_seconds': timeTakenSeconds,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAttemptsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? testId,
      Value<String>? questionId,
      Value<int?>? selectedOption,
      Value<String?>? confidenceLevel,
      Value<bool?>? isCorrect,
      Value<int?>? timeTakenSeconds,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return UserAttemptsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      testId: testId ?? this.testId,
      questionId: questionId ?? this.questionId,
      selectedOption: selectedOption ?? this.selectedOption,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      isCorrect: isCorrect ?? this.isCorrect,
      timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (selectedOption.present) {
      map['selected_option'] = Variable<int>(selectedOption.value);
    }
    if (confidenceLevel.present) {
      map['confidence_level'] = Variable<String>(confidenceLevel.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (timeTakenSeconds.present) {
      map['time_taken_seconds'] = Variable<int>(timeTakenSeconds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('testId: $testId, ')
          ..write('questionId: $questionId, ')
          ..write('selectedOption: $selectedOption, ')
          ..write('confidenceLevel: $confidenceLevel, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpacedRepetitionTable extends SpacedRepetition
    with TableInfo<$SpacedRepetitionTable, SpacedRepetitionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpacedRepetitionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nextReviewDateMeta =
      const VerificationMeta('nextReviewDate');
  @override
  late final GeneratedColumn<String> nextReviewDate = GeneratedColumn<String>(
      'next_review_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _masteredMeta =
      const VerificationMeta('mastered');
  @override
  late final GeneratedColumn<bool> mastered = GeneratedColumn<bool>(
      'mastered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("mastered" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        questionId,
        intervalDays,
        nextReviewDate,
        mastered,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spaced_repetition';
  @override
  VerificationContext validateIntegrity(
      Insertable<SpacedRepetitionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    } else if (isInserting) {
      context.missing(_intervalDaysMeta);
    }
    if (data.containsKey('next_review_date')) {
      context.handle(
          _nextReviewDateMeta,
          nextReviewDate.isAcceptableOrUnknown(
              data['next_review_date']!, _nextReviewDateMeta));
    } else if (isInserting) {
      context.missing(_nextReviewDateMeta);
    }
    if (data.containsKey('mastered')) {
      context.handle(_masteredMeta,
          mastered.isAcceptableOrUnknown(data['mastered']!, _masteredMeta));
    } else if (isInserting) {
      context.missing(_masteredMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpacedRepetitionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpacedRepetitionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      nextReviewDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}next_review_date'])!,
      mastered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mastered'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SpacedRepetitionTable createAlias(String alias) {
    return $SpacedRepetitionTable(attachedDatabase, alias);
  }
}

class SpacedRepetitionData extends DataClass
    implements Insertable<SpacedRepetitionData> {
  final String id;
  final String userId;
  final String questionId;
  final int intervalDays;
  final String nextReviewDate;
  final bool mastered;
  final DateTime createdAt;
  const SpacedRepetitionData(
      {required this.id,
      required this.userId,
      required this.questionId,
      required this.intervalDays,
      required this.nextReviewDate,
      required this.mastered,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['question_id'] = Variable<String>(questionId);
    map['interval_days'] = Variable<int>(intervalDays);
    map['next_review_date'] = Variable<String>(nextReviewDate);
    map['mastered'] = Variable<bool>(mastered);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SpacedRepetitionCompanion toCompanion(bool nullToAbsent) {
    return SpacedRepetitionCompanion(
      id: Value(id),
      userId: Value(userId),
      questionId: Value(questionId),
      intervalDays: Value(intervalDays),
      nextReviewDate: Value(nextReviewDate),
      mastered: Value(mastered),
      createdAt: Value(createdAt),
    );
  }

  factory SpacedRepetitionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpacedRepetitionData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      nextReviewDate: serializer.fromJson<String>(json['nextReviewDate']),
      mastered: serializer.fromJson<bool>(json['mastered']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'questionId': serializer.toJson<String>(questionId),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'nextReviewDate': serializer.toJson<String>(nextReviewDate),
      'mastered': serializer.toJson<bool>(mastered),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SpacedRepetitionData copyWith(
          {String? id,
          String? userId,
          String? questionId,
          int? intervalDays,
          String? nextReviewDate,
          bool? mastered,
          DateTime? createdAt}) =>
      SpacedRepetitionData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        questionId: questionId ?? this.questionId,
        intervalDays: intervalDays ?? this.intervalDays,
        nextReviewDate: nextReviewDate ?? this.nextReviewDate,
        mastered: mastered ?? this.mastered,
        createdAt: createdAt ?? this.createdAt,
      );
  SpacedRepetitionData copyWithCompanion(SpacedRepetitionCompanion data) {
    return SpacedRepetitionData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      mastered: data.mastered.present ? data.mastered.value : this.mastered,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpacedRepetitionData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('mastered: $mastered, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, questionId, intervalDays,
      nextReviewDate, mastered, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpacedRepetitionData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.questionId == this.questionId &&
          other.intervalDays == this.intervalDays &&
          other.nextReviewDate == this.nextReviewDate &&
          other.mastered == this.mastered &&
          other.createdAt == this.createdAt);
}

class SpacedRepetitionCompanion extends UpdateCompanion<SpacedRepetitionData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> questionId;
  final Value<int> intervalDays;
  final Value<String> nextReviewDate;
  final Value<bool> mastered;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SpacedRepetitionCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.mastered = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpacedRepetitionCompanion.insert({
    required String id,
    required String userId,
    required String questionId,
    required int intervalDays,
    required String nextReviewDate,
    required bool mastered,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        questionId = Value(questionId),
        intervalDays = Value(intervalDays),
        nextReviewDate = Value(nextReviewDate),
        mastered = Value(mastered),
        createdAt = Value(createdAt);
  static Insertable<SpacedRepetitionData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? questionId,
    Expression<int>? intervalDays,
    Expression<String>? nextReviewDate,
    Expression<bool>? mastered,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (questionId != null) 'question_id': questionId,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (mastered != null) 'mastered': mastered,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpacedRepetitionCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? questionId,
      Value<int>? intervalDays,
      Value<String>? nextReviewDate,
      Value<bool>? mastered,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SpacedRepetitionCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      intervalDays: intervalDays ?? this.intervalDays,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      mastered: mastered ?? this.mastered,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<String>(nextReviewDate.value);
    }
    if (mastered.present) {
      map['mastered'] = Variable<bool>(mastered.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpacedRepetitionCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('mastered: $mastered, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TaxonomyNodesTable taxonomyNodes = $TaxonomyNodesTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $TestsTable tests = $TestsTable(this);
  late final $TestQuestionMapTable testQuestionMap =
      $TestQuestionMapTable(this);
  late final $SyncLedgerTable syncLedger = $SyncLedgerTable(this);
  late final $UserAttemptsTable userAttempts = $UserAttemptsTable(this);
  late final $SpacedRepetitionTable spacedRepetition =
      $SpacedRepetitionTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final QuestionsDao questionsDao = QuestionsDao(this as AppDatabase);
  late final TestsDao testsDao = TestsDao(this as AppDatabase);
  late final AttemptsDao attemptsDao = AttemptsDao(this as AppDatabase);
  late final SpacedRepetitionDao spacedRepetitionDao =
      SpacedRepetitionDao(this as AppDatabase);
  late final SyncLedgerDao syncLedgerDao = SyncLedgerDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        taxonomyNodes,
        questions,
        tests,
        testQuestionMap,
        syncLedger,
        userAttempts,
        spacedRepetition
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  Value<String?> phoneNumber,
  Value<String?> selectedExam,
  Value<String?> uiLanguage,
  Value<int?> dailyCapacityMinutes,
  required String weakDomains,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String?> phoneNumber,
  Value<String?> selectedExam,
  Value<String?> uiLanguage,
  Value<int?> dailyCapacityMinutes,
  Value<String> weakDomains,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedExam => $composableBuilder(
      column: $table.selectedExam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uiLanguage => $composableBuilder(
      column: $table.uiLanguage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyCapacityMinutes => $composableBuilder(
      column: $table.dailyCapacityMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weakDomains => $composableBuilder(
      column: $table.weakDomains, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedExam => $composableBuilder(
      column: $table.selectedExam,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uiLanguage => $composableBuilder(
      column: $table.uiLanguage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyCapacityMinutes => $composableBuilder(
      column: $table.dailyCapacityMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weakDomains => $composableBuilder(
      column: $table.weakDomains, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get selectedExam => $composableBuilder(
      column: $table.selectedExam, builder: (column) => column);

  GeneratedColumn<String> get uiLanguage => $composableBuilder(
      column: $table.uiLanguage, builder: (column) => column);

  GeneratedColumn<int> get dailyCapacityMinutes => $composableBuilder(
      column: $table.dailyCapacityMinutes, builder: (column) => column);

  GeneratedColumn<String> get weakDomains => $composableBuilder(
      column: $table.weakDomains, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> selectedExam = const Value.absent(),
            Value<String?> uiLanguage = const Value.absent(),
            Value<int?> dailyCapacityMinutes = const Value.absent(),
            Value<String> weakDomains = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            phoneNumber: phoneNumber,
            selectedExam: selectedExam,
            uiLanguage: uiLanguage,
            dailyCapacityMinutes: dailyCapacityMinutes,
            weakDomains: weakDomains,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> selectedExam = const Value.absent(),
            Value<String?> uiLanguage = const Value.absent(),
            Value<int?> dailyCapacityMinutes = const Value.absent(),
            required String weakDomains,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            phoneNumber: phoneNumber,
            selectedExam: selectedExam,
            uiLanguage: uiLanguage,
            dailyCapacityMinutes: dailyCapacityMinutes,
            weakDomains: weakDomains,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$TaxonomyNodesTableCreateCompanionBuilder = TaxonomyNodesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> parentId,
  required int level,
  Value<int> rowid,
});
typedef $$TaxonomyNodesTableUpdateCompanionBuilder = TaxonomyNodesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> parentId,
  Value<int> level,
  Value<int> rowid,
});

class $$TaxonomyNodesTableFilterComposer
    extends Composer<_$AppDatabase, $TaxonomyNodesTable> {
  $$TaxonomyNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));
}

class $$TaxonomyNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxonomyNodesTable> {
  $$TaxonomyNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));
}

class $$TaxonomyNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxonomyNodesTable> {
  $$TaxonomyNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$TaxonomyNodesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaxonomyNodesTable,
    TaxonomyNode,
    $$TaxonomyNodesTableFilterComposer,
    $$TaxonomyNodesTableOrderingComposer,
    $$TaxonomyNodesTableAnnotationComposer,
    $$TaxonomyNodesTableCreateCompanionBuilder,
    $$TaxonomyNodesTableUpdateCompanionBuilder,
    (
      TaxonomyNode,
      BaseReferences<_$AppDatabase, $TaxonomyNodesTable, TaxonomyNode>
    ),
    TaxonomyNode,
    PrefetchHooks Function()> {
  $$TaxonomyNodesTableTableManager(_$AppDatabase db, $TaxonomyNodesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxonomyNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxonomyNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxonomyNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaxonomyNodesCompanion(
            id: id,
            name: name,
            parentId: parentId,
            level: level,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> parentId = const Value.absent(),
            required int level,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaxonomyNodesCompanion.insert(
            id: id,
            name: name,
            parentId: parentId,
            level: level,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TaxonomyNodesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaxonomyNodesTable,
    TaxonomyNode,
    $$TaxonomyNodesTableFilterComposer,
    $$TaxonomyNodesTableOrderingComposer,
    $$TaxonomyNodesTableAnnotationComposer,
    $$TaxonomyNodesTableCreateCompanionBuilder,
    $$TaxonomyNodesTableUpdateCompanionBuilder,
    (
      TaxonomyNode,
      BaseReferences<_$AppDatabase, $TaxonomyNodesTable, TaxonomyNode>
    ),
    TaxonomyNode,
    PrefetchHooks Function()>;
typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  required String id,
  required String taxonomyId,
  required String questionEn,
  required String questionHi,
  required String optionsEn,
  required String optionsHi,
  required int correctOption,
  required String difficultyLevel,
  required String explanationEn,
  required String explanationHi,
  required String explanationHinglish,
  Value<String?> shortcutFormulaNote,
  Value<String?> commonMistakeNote,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<String> id,
  Value<String> taxonomyId,
  Value<String> questionEn,
  Value<String> questionHi,
  Value<String> optionsEn,
  Value<String> optionsHi,
  Value<int> correctOption,
  Value<String> difficultyLevel,
  Value<String> explanationEn,
  Value<String> explanationHi,
  Value<String> explanationHinglish,
  Value<String?> shortcutFormulaNote,
  Value<String?> commonMistakeNote,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taxonomyId => $composableBuilder(
      column: $table.taxonomyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionEn => $composableBuilder(
      column: $table.questionEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionHi => $composableBuilder(
      column: $table.questionHi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionsEn => $composableBuilder(
      column: $table.optionsEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionsHi => $composableBuilder(
      column: $table.optionsHi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctOption => $composableBuilder(
      column: $table.correctOption, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanationEn => $composableBuilder(
      column: $table.explanationEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanationHi => $composableBuilder(
      column: $table.explanationHi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanationHinglish => $composableBuilder(
      column: $table.explanationHinglish,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortcutFormulaNote => $composableBuilder(
      column: $table.shortcutFormulaNote,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commonMistakeNote => $composableBuilder(
      column: $table.commonMistakeNote,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taxonomyId => $composableBuilder(
      column: $table.taxonomyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionEn => $composableBuilder(
      column: $table.questionEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionHi => $composableBuilder(
      column: $table.questionHi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionsEn => $composableBuilder(
      column: $table.optionsEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionsHi => $composableBuilder(
      column: $table.optionsHi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctOption => $composableBuilder(
      column: $table.correctOption,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanationEn => $composableBuilder(
      column: $table.explanationEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanationHi => $composableBuilder(
      column: $table.explanationHi,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanationHinglish => $composableBuilder(
      column: $table.explanationHinglish,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortcutFormulaNote => $composableBuilder(
      column: $table.shortcutFormulaNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commonMistakeNote => $composableBuilder(
      column: $table.commonMistakeNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taxonomyId => $composableBuilder(
      column: $table.taxonomyId, builder: (column) => column);

  GeneratedColumn<String> get questionEn => $composableBuilder(
      column: $table.questionEn, builder: (column) => column);

  GeneratedColumn<String> get questionHi => $composableBuilder(
      column: $table.questionHi, builder: (column) => column);

  GeneratedColumn<String> get optionsEn =>
      $composableBuilder(column: $table.optionsEn, builder: (column) => column);

  GeneratedColumn<String> get optionsHi =>
      $composableBuilder(column: $table.optionsHi, builder: (column) => column);

  GeneratedColumn<int> get correctOption => $composableBuilder(
      column: $table.correctOption, builder: (column) => column);

  GeneratedColumn<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel, builder: (column) => column);

  GeneratedColumn<String> get explanationEn => $composableBuilder(
      column: $table.explanationEn, builder: (column) => column);

  GeneratedColumn<String> get explanationHi => $composableBuilder(
      column: $table.explanationHi, builder: (column) => column);

  GeneratedColumn<String> get explanationHinglish => $composableBuilder(
      column: $table.explanationHinglish, builder: (column) => column);

  GeneratedColumn<String> get shortcutFormulaNote => $composableBuilder(
      column: $table.shortcutFormulaNote, builder: (column) => column);

  GeneratedColumn<String> get commonMistakeNote => $composableBuilder(
      column: $table.commonMistakeNote, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$QuestionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionsTable,
    Question,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (Question, BaseReferences<_$AppDatabase, $QuestionsTable, Question>),
    Question,
    PrefetchHooks Function()> {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taxonomyId = const Value.absent(),
            Value<String> questionEn = const Value.absent(),
            Value<String> questionHi = const Value.absent(),
            Value<String> optionsEn = const Value.absent(),
            Value<String> optionsHi = const Value.absent(),
            Value<int> correctOption = const Value.absent(),
            Value<String> difficultyLevel = const Value.absent(),
            Value<String> explanationEn = const Value.absent(),
            Value<String> explanationHi = const Value.absent(),
            Value<String> explanationHinglish = const Value.absent(),
            Value<String?> shortcutFormulaNote = const Value.absent(),
            Value<String?> commonMistakeNote = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsCompanion(
            id: id,
            taxonomyId: taxonomyId,
            questionEn: questionEn,
            questionHi: questionHi,
            optionsEn: optionsEn,
            optionsHi: optionsHi,
            correctOption: correctOption,
            difficultyLevel: difficultyLevel,
            explanationEn: explanationEn,
            explanationHi: explanationHi,
            explanationHinglish: explanationHinglish,
            shortcutFormulaNote: shortcutFormulaNote,
            commonMistakeNote: commonMistakeNote,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taxonomyId,
            required String questionEn,
            required String questionHi,
            required String optionsEn,
            required String optionsHi,
            required int correctOption,
            required String difficultyLevel,
            required String explanationEn,
            required String explanationHi,
            required String explanationHinglish,
            Value<String?> shortcutFormulaNote = const Value.absent(),
            Value<String?> commonMistakeNote = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsCompanion.insert(
            id: id,
            taxonomyId: taxonomyId,
            questionEn: questionEn,
            questionHi: questionHi,
            optionsEn: optionsEn,
            optionsHi: optionsHi,
            correctOption: correctOption,
            difficultyLevel: difficultyLevel,
            explanationEn: explanationEn,
            explanationHi: explanationHi,
            explanationHinglish: explanationHinglish,
            shortcutFormulaNote: shortcutFormulaNote,
            commonMistakeNote: commonMistakeNote,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuestionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionsTable,
    Question,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (Question, BaseReferences<_$AppDatabase, $QuestionsTable, Question>),
    Question,
    PrefetchHooks Function()>;
typedef $$TestsTableCreateCompanionBuilder = TestsCompanion Function({
  required String id,
  required String userId,
  required String testType,
  required int totalQuestions,
  required int timeLimitMinutes,
  required DateTime startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$TestsTableUpdateCompanionBuilder = TestsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> testType,
  Value<int> totalQuestions,
  Value<int> timeLimitMinutes,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

class $$TestsTableFilterComposer extends Composer<_$AppDatabase, $TestsTable> {
  $$TestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testType => $composableBuilder(
      column: $table.testType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeLimitMinutes => $composableBuilder(
      column: $table.timeLimitMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$TestsTableOrderingComposer
    extends Composer<_$AppDatabase, $TestsTable> {
  $$TestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testType => $composableBuilder(
      column: $table.testType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeLimitMinutes => $composableBuilder(
      column: $table.timeLimitMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$TestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestsTable> {
  $$TestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get testType =>
      $composableBuilder(column: $table.testType, builder: (column) => column);

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions, builder: (column) => column);

  GeneratedColumn<int> get timeLimitMinutes => $composableBuilder(
      column: $table.timeLimitMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$TestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableAnnotationComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, BaseReferences<_$AppDatabase, $TestsTable, Test>),
    Test,
    PrefetchHooks Function()> {
  $$TestsTableTableManager(_$AppDatabase db, $TestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> testType = const Value.absent(),
            Value<int> totalQuestions = const Value.absent(),
            Value<int> timeLimitMinutes = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TestsCompanion(
            id: id,
            userId: userId,
            testType: testType,
            totalQuestions: totalQuestions,
            timeLimitMinutes: timeLimitMinutes,
            startedAt: startedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String testType,
            required int totalQuestions,
            required int timeLimitMinutes,
            required DateTime startedAt,
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TestsCompanion.insert(
            id: id,
            userId: userId,
            testType: testType,
            totalQuestions: totalQuestions,
            timeLimitMinutes: timeLimitMinutes,
            startedAt: startedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableAnnotationComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, BaseReferences<_$AppDatabase, $TestsTable, Test>),
    Test,
    PrefetchHooks Function()>;
typedef $$TestQuestionMapTableCreateCompanionBuilder = TestQuestionMapCompanion
    Function({
  required String id,
  required String testId,
  required String questionId,
  required int sequenceOrder,
  Value<int> rowid,
});
typedef $$TestQuestionMapTableUpdateCompanionBuilder = TestQuestionMapCompanion
    Function({
  Value<String> id,
  Value<String> testId,
  Value<String> questionId,
  Value<int> sequenceOrder,
  Value<int> rowid,
});

class $$TestQuestionMapTableFilterComposer
    extends Composer<_$AppDatabase, $TestQuestionMapTable> {
  $$TestQuestionMapTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testId => $composableBuilder(
      column: $table.testId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder, builder: (column) => ColumnFilters(column));
}

class $$TestQuestionMapTableOrderingComposer
    extends Composer<_$AppDatabase, $TestQuestionMapTable> {
  $$TestQuestionMapTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testId => $composableBuilder(
      column: $table.testId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$TestQuestionMapTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestQuestionMapTable> {
  $$TestQuestionMapTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testId =>
      $composableBuilder(column: $table.testId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder, builder: (column) => column);
}

class $$TestQuestionMapTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TestQuestionMapTable,
    TestQuestionMapData,
    $$TestQuestionMapTableFilterComposer,
    $$TestQuestionMapTableOrderingComposer,
    $$TestQuestionMapTableAnnotationComposer,
    $$TestQuestionMapTableCreateCompanionBuilder,
    $$TestQuestionMapTableUpdateCompanionBuilder,
    (
      TestQuestionMapData,
      BaseReferences<_$AppDatabase, $TestQuestionMapTable, TestQuestionMapData>
    ),
    TestQuestionMapData,
    PrefetchHooks Function()> {
  $$TestQuestionMapTableTableManager(
      _$AppDatabase db, $TestQuestionMapTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestQuestionMapTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestQuestionMapTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestQuestionMapTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> testId = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<int> sequenceOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TestQuestionMapCompanion(
            id: id,
            testId: testId,
            questionId: questionId,
            sequenceOrder: sequenceOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String testId,
            required String questionId,
            required int sequenceOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              TestQuestionMapCompanion.insert(
            id: id,
            testId: testId,
            questionId: questionId,
            sequenceOrder: sequenceOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TestQuestionMapTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TestQuestionMapTable,
    TestQuestionMapData,
    $$TestQuestionMapTableFilterComposer,
    $$TestQuestionMapTableOrderingComposer,
    $$TestQuestionMapTableAnnotationComposer,
    $$TestQuestionMapTableCreateCompanionBuilder,
    $$TestQuestionMapTableUpdateCompanionBuilder,
    (
      TestQuestionMapData,
      BaseReferences<_$AppDatabase, $TestQuestionMapTable, TestQuestionMapData>
    ),
    TestQuestionMapData,
    PrefetchHooks Function()>;
typedef $$SyncLedgerTableCreateCompanionBuilder = SyncLedgerCompanion Function({
  required String id,
  required String eventType,
  required String payload,
  required DateTime clientTimestamp,
  required bool processedStatus,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SyncLedgerTableUpdateCompanionBuilder = SyncLedgerCompanion Function({
  Value<String> id,
  Value<String> eventType,
  Value<String> payload,
  Value<DateTime> clientTimestamp,
  Value<bool> processedStatus,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SyncLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLedgerTable> {
  $$SyncLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientTimestamp => $composableBuilder(
      column: $table.clientTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get processedStatus => $composableBuilder(
      column: $table.processedStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SyncLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLedgerTable> {
  $$SyncLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientTimestamp => $composableBuilder(
      column: $table.clientTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get processedStatus => $composableBuilder(
      column: $table.processedStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLedgerTable> {
  $$SyncLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get clientTimestamp => $composableBuilder(
      column: $table.clientTimestamp, builder: (column) => column);

  GeneratedColumn<bool> get processedStatus => $composableBuilder(
      column: $table.processedStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncLedgerTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncLedgerTable,
    SyncLedgerData,
    $$SyncLedgerTableFilterComposer,
    $$SyncLedgerTableOrderingComposer,
    $$SyncLedgerTableAnnotationComposer,
    $$SyncLedgerTableCreateCompanionBuilder,
    $$SyncLedgerTableUpdateCompanionBuilder,
    (
      SyncLedgerData,
      BaseReferences<_$AppDatabase, $SyncLedgerTable, SyncLedgerData>
    ),
    SyncLedgerData,
    PrefetchHooks Function()> {
  $$SyncLedgerTableTableManager(_$AppDatabase db, $SyncLedgerTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> clientTimestamp = const Value.absent(),
            Value<bool> processedStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLedgerCompanion(
            id: id,
            eventType: eventType,
            payload: payload,
            clientTimestamp: clientTimestamp,
            processedStatus: processedStatus,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String eventType,
            required String payload,
            required DateTime clientTimestamp,
            required bool processedStatus,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLedgerCompanion.insert(
            id: id,
            eventType: eventType,
            payload: payload,
            clientTimestamp: clientTimestamp,
            processedStatus: processedStatus,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncLedgerTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncLedgerTable,
    SyncLedgerData,
    $$SyncLedgerTableFilterComposer,
    $$SyncLedgerTableOrderingComposer,
    $$SyncLedgerTableAnnotationComposer,
    $$SyncLedgerTableCreateCompanionBuilder,
    $$SyncLedgerTableUpdateCompanionBuilder,
    (
      SyncLedgerData,
      BaseReferences<_$AppDatabase, $SyncLedgerTable, SyncLedgerData>
    ),
    SyncLedgerData,
    PrefetchHooks Function()>;
typedef $$UserAttemptsTableCreateCompanionBuilder = UserAttemptsCompanion
    Function({
  required String id,
  required String userId,
  required String testId,
  required String questionId,
  Value<int?> selectedOption,
  Value<String?> confidenceLevel,
  Value<bool?> isCorrect,
  Value<int?> timeTakenSeconds,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UserAttemptsTableUpdateCompanionBuilder = UserAttemptsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> testId,
  Value<String> questionId,
  Value<int?> selectedOption,
  Value<String?> confidenceLevel,
  Value<bool?> isCorrect,
  Value<int?> timeTakenSeconds,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UserAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAttemptsTable> {
  $$UserAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testId => $composableBuilder(
      column: $table.testId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get selectedOption => $composableBuilder(
      column: $table.selectedOption,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get confidenceLevel => $composableBuilder(
      column: $table.confidenceLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UserAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAttemptsTable> {
  $$UserAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testId => $composableBuilder(
      column: $table.testId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get selectedOption => $composableBuilder(
      column: $table.selectedOption,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get confidenceLevel => $composableBuilder(
      column: $table.confidenceLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UserAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAttemptsTable> {
  $$UserAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get testId =>
      $composableBuilder(column: $table.testId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<int> get selectedOption => $composableBuilder(
      column: $table.selectedOption, builder: (column) => column);

  GeneratedColumn<String> get confidenceLevel => $composableBuilder(
      column: $table.confidenceLevel, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserAttemptsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserAttemptsTable,
    UserAttempt,
    $$UserAttemptsTableFilterComposer,
    $$UserAttemptsTableOrderingComposer,
    $$UserAttemptsTableAnnotationComposer,
    $$UserAttemptsTableCreateCompanionBuilder,
    $$UserAttemptsTableUpdateCompanionBuilder,
    (
      UserAttempt,
      BaseReferences<_$AppDatabase, $UserAttemptsTable, UserAttempt>
    ),
    UserAttempt,
    PrefetchHooks Function()> {
  $$UserAttemptsTableTableManager(_$AppDatabase db, $UserAttemptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> testId = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<int?> selectedOption = const Value.absent(),
            Value<String?> confidenceLevel = const Value.absent(),
            Value<bool?> isCorrect = const Value.absent(),
            Value<int?> timeTakenSeconds = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserAttemptsCompanion(
            id: id,
            userId: userId,
            testId: testId,
            questionId: questionId,
            selectedOption: selectedOption,
            confidenceLevel: confidenceLevel,
            isCorrect: isCorrect,
            timeTakenSeconds: timeTakenSeconds,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String testId,
            required String questionId,
            Value<int?> selectedOption = const Value.absent(),
            Value<String?> confidenceLevel = const Value.absent(),
            Value<bool?> isCorrect = const Value.absent(),
            Value<int?> timeTakenSeconds = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserAttemptsCompanion.insert(
            id: id,
            userId: userId,
            testId: testId,
            questionId: questionId,
            selectedOption: selectedOption,
            confidenceLevel: confidenceLevel,
            isCorrect: isCorrect,
            timeTakenSeconds: timeTakenSeconds,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserAttemptsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserAttemptsTable,
    UserAttempt,
    $$UserAttemptsTableFilterComposer,
    $$UserAttemptsTableOrderingComposer,
    $$UserAttemptsTableAnnotationComposer,
    $$UserAttemptsTableCreateCompanionBuilder,
    $$UserAttemptsTableUpdateCompanionBuilder,
    (
      UserAttempt,
      BaseReferences<_$AppDatabase, $UserAttemptsTable, UserAttempt>
    ),
    UserAttempt,
    PrefetchHooks Function()>;
typedef $$SpacedRepetitionTableCreateCompanionBuilder
    = SpacedRepetitionCompanion Function({
  required String id,
  required String userId,
  required String questionId,
  required int intervalDays,
  required String nextReviewDate,
  required bool mastered,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SpacedRepetitionTableUpdateCompanionBuilder
    = SpacedRepetitionCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> questionId,
  Value<int> intervalDays,
  Value<String> nextReviewDate,
  Value<bool> mastered,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SpacedRepetitionTableFilterComposer
    extends Composer<_$AppDatabase, $SpacedRepetitionTable> {
  $$SpacedRepetitionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mastered => $composableBuilder(
      column: $table.mastered, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SpacedRepetitionTableOrderingComposer
    extends Composer<_$AppDatabase, $SpacedRepetitionTable> {
  $$SpacedRepetitionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mastered => $composableBuilder(
      column: $table.mastered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SpacedRepetitionTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpacedRepetitionTable> {
  $$SpacedRepetitionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<String> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate, builder: (column) => column);

  GeneratedColumn<bool> get mastered =>
      $composableBuilder(column: $table.mastered, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SpacedRepetitionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SpacedRepetitionTable,
    SpacedRepetitionData,
    $$SpacedRepetitionTableFilterComposer,
    $$SpacedRepetitionTableOrderingComposer,
    $$SpacedRepetitionTableAnnotationComposer,
    $$SpacedRepetitionTableCreateCompanionBuilder,
    $$SpacedRepetitionTableUpdateCompanionBuilder,
    (
      SpacedRepetitionData,
      BaseReferences<_$AppDatabase, $SpacedRepetitionTable,
          SpacedRepetitionData>
    ),
    SpacedRepetitionData,
    PrefetchHooks Function()> {
  $$SpacedRepetitionTableTableManager(
      _$AppDatabase db, $SpacedRepetitionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpacedRepetitionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpacedRepetitionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpacedRepetitionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<String> nextReviewDate = const Value.absent(),
            Value<bool> mastered = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SpacedRepetitionCompanion(
            id: id,
            userId: userId,
            questionId: questionId,
            intervalDays: intervalDays,
            nextReviewDate: nextReviewDate,
            mastered: mastered,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String questionId,
            required int intervalDays,
            required String nextReviewDate,
            required bool mastered,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SpacedRepetitionCompanion.insert(
            id: id,
            userId: userId,
            questionId: questionId,
            intervalDays: intervalDays,
            nextReviewDate: nextReviewDate,
            mastered: mastered,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SpacedRepetitionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SpacedRepetitionTable,
    SpacedRepetitionData,
    $$SpacedRepetitionTableFilterComposer,
    $$SpacedRepetitionTableOrderingComposer,
    $$SpacedRepetitionTableAnnotationComposer,
    $$SpacedRepetitionTableCreateCompanionBuilder,
    $$SpacedRepetitionTableUpdateCompanionBuilder,
    (
      SpacedRepetitionData,
      BaseReferences<_$AppDatabase, $SpacedRepetitionTable,
          SpacedRepetitionData>
    ),
    SpacedRepetitionData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TaxonomyNodesTableTableManager get taxonomyNodes =>
      $$TaxonomyNodesTableTableManager(_db, _db.taxonomyNodes);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$TestsTableTableManager get tests =>
      $$TestsTableTableManager(_db, _db.tests);
  $$TestQuestionMapTableTableManager get testQuestionMap =>
      $$TestQuestionMapTableTableManager(_db, _db.testQuestionMap);
  $$SyncLedgerTableTableManager get syncLedger =>
      $$SyncLedgerTableTableManager(_db, _db.syncLedger);
  $$UserAttemptsTableTableManager get userAttempts =>
      $$UserAttemptsTableTableManager(_db, _db.userAttempts);
  $$SpacedRepetitionTableTableManager get spacedRepetition =>
      $$SpacedRepetitionTableTableManager(_db, _db.spacedRepetition);
}
