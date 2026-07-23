// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TestResultsTable extends TestResults
    with TableInfo<$TestResultsTable, TestResultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testVersionMeta = const VerificationMeta(
    'testVersion',
  );
  @override
  late final GeneratedColumn<String> testVersion = GeneratedColumn<String>(
    'test_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceModelMeta = const VerificationMeta(
    'deviceModel',
  );
  @override
  late final GeneratedColumn<String> deviceModel = GeneratedColumn<String>(
    'device_model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _screenSizeMeta = const VerificationMeta(
    'screenSize',
  );
  @override
  late final GeneratedColumn<String> screenSize = GeneratedColumn<String>(
    'screen_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _screenDensityMeta = const VerificationMeta(
    'screenDensity',
  );
  @override
  late final GeneratedColumn<double> screenDensity = GeneratedColumn<double>(
    'screen_density',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brightnessIfAvailableMeta =
      const VerificationMeta('brightnessIfAvailable');
  @override
  late final GeneratedColumn<double> brightnessIfAvailable =
      GeneratedColumn<double>(
        'brightness_if_available',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _viewingDistanceMeta = const VerificationMeta(
    'viewingDistance',
  );
  @override
  late final GeneratedColumn<double> viewingDistance = GeneratedColumn<double>(
    'viewing_distance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eyeTestedMeta = const VerificationMeta(
    'eyeTested',
  );
  @override
  late final GeneratedColumn<String> eyeTested = GeneratedColumn<String>(
    'eye_tested',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctionUsedMeta = const VerificationMeta(
    'correctionUsed',
  );
  @override
  late final GeneratedColumn<String> correctionUsed = GeneratedColumn<String>(
    'correction_used',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawResponsesJsonMeta = const VerificationMeta(
    'rawResponsesJson',
  );
  @override
  late final GeneratedColumn<String> rawResponsesJson = GeneratedColumn<String>(
    'raw_responses_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reactionTimeMeta = const VerificationMeta(
    'reactionTime',
  );
  @override
  late final GeneratedColumn<double> reactionTime = GeneratedColumn<double>(
    'reaction_time',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoringJsonMeta = const VerificationMeta(
    'scoringJson',
  );
  @override
  late final GeneratedColumn<String> scoringJson = GeneratedColumn<String>(
    'scoring_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceJsonMeta = const VerificationMeta(
    'confidenceJson',
  );
  @override
  late final GeneratedColumn<String> confidenceJson = GeneratedColumn<String>(
    'confidence_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _environmentNotesMeta = const VerificationMeta(
    'environmentNotes',
  );
  @override
  late final GeneratedColumn<String> environmentNotes = GeneratedColumn<String>(
    'environment_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    testId,
    testVersion,
    date,
    deviceModel,
    screenSize,
    screenDensity,
    brightnessIfAvailable,
    viewingDistance,
    eyeTested,
    correctionUsed,
    rawResponsesJson,
    score,
    accuracy,
    reactionTime,
    scoringJson,
    confidenceJson,
    environmentNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestResultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('test_version')) {
      context.handle(
        _testVersionMeta,
        testVersion.isAcceptableOrUnknown(
          data['test_version']!,
          _testVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_testVersionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('device_model')) {
      context.handle(
        _deviceModelMeta,
        deviceModel.isAcceptableOrUnknown(
          data['device_model']!,
          _deviceModelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceModelMeta);
    }
    if (data.containsKey('screen_size')) {
      context.handle(
        _screenSizeMeta,
        screenSize.isAcceptableOrUnknown(data['screen_size']!, _screenSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_screenSizeMeta);
    }
    if (data.containsKey('screen_density')) {
      context.handle(
        _screenDensityMeta,
        screenDensity.isAcceptableOrUnknown(
          data['screen_density']!,
          _screenDensityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_screenDensityMeta);
    }
    if (data.containsKey('brightness_if_available')) {
      context.handle(
        _brightnessIfAvailableMeta,
        brightnessIfAvailable.isAcceptableOrUnknown(
          data['brightness_if_available']!,
          _brightnessIfAvailableMeta,
        ),
      );
    }
    if (data.containsKey('viewing_distance')) {
      context.handle(
        _viewingDistanceMeta,
        viewingDistance.isAcceptableOrUnknown(
          data['viewing_distance']!,
          _viewingDistanceMeta,
        ),
      );
    }
    if (data.containsKey('eye_tested')) {
      context.handle(
        _eyeTestedMeta,
        eyeTested.isAcceptableOrUnknown(data['eye_tested']!, _eyeTestedMeta),
      );
    } else if (isInserting) {
      context.missing(_eyeTestedMeta);
    }
    if (data.containsKey('correction_used')) {
      context.handle(
        _correctionUsedMeta,
        correctionUsed.isAcceptableOrUnknown(
          data['correction_used']!,
          _correctionUsedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctionUsedMeta);
    }
    if (data.containsKey('raw_responses_json')) {
      context.handle(
        _rawResponsesJsonMeta,
        rawResponsesJson.isAcceptableOrUnknown(
          data['raw_responses_json']!,
          _rawResponsesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rawResponsesJsonMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyMeta);
    }
    if (data.containsKey('reaction_time')) {
      context.handle(
        _reactionTimeMeta,
        reactionTime.isAcceptableOrUnknown(
          data['reaction_time']!,
          _reactionTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reactionTimeMeta);
    }
    if (data.containsKey('scoring_json')) {
      context.handle(
        _scoringJsonMeta,
        scoringJson.isAcceptableOrUnknown(
          data['scoring_json']!,
          _scoringJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scoringJsonMeta);
    }
    if (data.containsKey('confidence_json')) {
      context.handle(
        _confidenceJsonMeta,
        confidenceJson.isAcceptableOrUnknown(
          data['confidence_json']!,
          _confidenceJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confidenceJsonMeta);
    }
    if (data.containsKey('environment_notes')) {
      context.handle(
        _environmentNotesMeta,
        environmentNotes.isAcceptableOrUnknown(
          data['environment_notes']!,
          _environmentNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestResultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestResultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
      testVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_version'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      deviceModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_model'],
      )!,
      screenSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screen_size'],
      )!,
      screenDensity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}screen_density'],
      )!,
      brightnessIfAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brightness_if_available'],
      ),
      viewingDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}viewing_distance'],
      ),
      eyeTested: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}eye_tested'],
      )!,
      correctionUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correction_used'],
      )!,
      rawResponsesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_responses_json'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      )!,
      reactionTime: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reaction_time'],
      )!,
      scoringJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scoring_json'],
      )!,
      confidenceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence_json'],
      )!,
      environmentNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment_notes'],
      ),
    );
  }

  @override
  $TestResultsTable createAlias(String alias) {
    return $TestResultsTable(attachedDatabase, alias);
  }
}

class TestResultRow extends DataClass implements Insertable<TestResultRow> {
  /// Unique row id — the engine session id.
  final String id;
  final String testId;
  final String testVersion;
  final DateTime date;
  final String deviceModel;

  /// Human-readable, e.g. "1080x2400".
  final String screenSize;

  /// True PPI used to size stimuli for this session.
  final double screenDensity;
  final double? brightnessIfAvailable;

  /// Viewing distance in millimetres.
  final double? viewingDistance;

  /// [Eye] enum name.
  final String eyeTested;

  /// [CorrectionUsed] enum name.
  final String correctionUsed;

  /// JSON-encoded `List<TestResponse>`.
  final String rawResponsesJson;
  final double score;
  final double accuracy;
  final double reactionTime;

  /// JSON-encoded `TestScoring` (full metrics map, not just the scalars above).
  final String scoringJson;

  /// JSON-encoded `TestConfidence`.
  final String confidenceJson;
  final String? environmentNotes;
  const TestResultRow({
    required this.id,
    required this.testId,
    required this.testVersion,
    required this.date,
    required this.deviceModel,
    required this.screenSize,
    required this.screenDensity,
    this.brightnessIfAvailable,
    this.viewingDistance,
    required this.eyeTested,
    required this.correctionUsed,
    required this.rawResponsesJson,
    required this.score,
    required this.accuracy,
    required this.reactionTime,
    required this.scoringJson,
    required this.confidenceJson,
    this.environmentNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['test_id'] = Variable<String>(testId);
    map['test_version'] = Variable<String>(testVersion);
    map['date'] = Variable<DateTime>(date);
    map['device_model'] = Variable<String>(deviceModel);
    map['screen_size'] = Variable<String>(screenSize);
    map['screen_density'] = Variable<double>(screenDensity);
    if (!nullToAbsent || brightnessIfAvailable != null) {
      map['brightness_if_available'] = Variable<double>(brightnessIfAvailable);
    }
    if (!nullToAbsent || viewingDistance != null) {
      map['viewing_distance'] = Variable<double>(viewingDistance);
    }
    map['eye_tested'] = Variable<String>(eyeTested);
    map['correction_used'] = Variable<String>(correctionUsed);
    map['raw_responses_json'] = Variable<String>(rawResponsesJson);
    map['score'] = Variable<double>(score);
    map['accuracy'] = Variable<double>(accuracy);
    map['reaction_time'] = Variable<double>(reactionTime);
    map['scoring_json'] = Variable<String>(scoringJson);
    map['confidence_json'] = Variable<String>(confidenceJson);
    if (!nullToAbsent || environmentNotes != null) {
      map['environment_notes'] = Variable<String>(environmentNotes);
    }
    return map;
  }

  TestResultsCompanion toCompanion(bool nullToAbsent) {
    return TestResultsCompanion(
      id: Value(id),
      testId: Value(testId),
      testVersion: Value(testVersion),
      date: Value(date),
      deviceModel: Value(deviceModel),
      screenSize: Value(screenSize),
      screenDensity: Value(screenDensity),
      brightnessIfAvailable: brightnessIfAvailable == null && nullToAbsent
          ? const Value.absent()
          : Value(brightnessIfAvailable),
      viewingDistance: viewingDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(viewingDistance),
      eyeTested: Value(eyeTested),
      correctionUsed: Value(correctionUsed),
      rawResponsesJson: Value(rawResponsesJson),
      score: Value(score),
      accuracy: Value(accuracy),
      reactionTime: Value(reactionTime),
      scoringJson: Value(scoringJson),
      confidenceJson: Value(confidenceJson),
      environmentNotes: environmentNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(environmentNotes),
    );
  }

  factory TestResultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestResultRow(
      id: serializer.fromJson<String>(json['id']),
      testId: serializer.fromJson<String>(json['testId']),
      testVersion: serializer.fromJson<String>(json['testVersion']),
      date: serializer.fromJson<DateTime>(json['date']),
      deviceModel: serializer.fromJson<String>(json['deviceModel']),
      screenSize: serializer.fromJson<String>(json['screenSize']),
      screenDensity: serializer.fromJson<double>(json['screenDensity']),
      brightnessIfAvailable: serializer.fromJson<double?>(
        json['brightnessIfAvailable'],
      ),
      viewingDistance: serializer.fromJson<double?>(json['viewingDistance']),
      eyeTested: serializer.fromJson<String>(json['eyeTested']),
      correctionUsed: serializer.fromJson<String>(json['correctionUsed']),
      rawResponsesJson: serializer.fromJson<String>(json['rawResponsesJson']),
      score: serializer.fromJson<double>(json['score']),
      accuracy: serializer.fromJson<double>(json['accuracy']),
      reactionTime: serializer.fromJson<double>(json['reactionTime']),
      scoringJson: serializer.fromJson<String>(json['scoringJson']),
      confidenceJson: serializer.fromJson<String>(json['confidenceJson']),
      environmentNotes: serializer.fromJson<String?>(json['environmentNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'testId': serializer.toJson<String>(testId),
      'testVersion': serializer.toJson<String>(testVersion),
      'date': serializer.toJson<DateTime>(date),
      'deviceModel': serializer.toJson<String>(deviceModel),
      'screenSize': serializer.toJson<String>(screenSize),
      'screenDensity': serializer.toJson<double>(screenDensity),
      'brightnessIfAvailable': serializer.toJson<double?>(
        brightnessIfAvailable,
      ),
      'viewingDistance': serializer.toJson<double?>(viewingDistance),
      'eyeTested': serializer.toJson<String>(eyeTested),
      'correctionUsed': serializer.toJson<String>(correctionUsed),
      'rawResponsesJson': serializer.toJson<String>(rawResponsesJson),
      'score': serializer.toJson<double>(score),
      'accuracy': serializer.toJson<double>(accuracy),
      'reactionTime': serializer.toJson<double>(reactionTime),
      'scoringJson': serializer.toJson<String>(scoringJson),
      'confidenceJson': serializer.toJson<String>(confidenceJson),
      'environmentNotes': serializer.toJson<String?>(environmentNotes),
    };
  }

  TestResultRow copyWith({
    String? id,
    String? testId,
    String? testVersion,
    DateTime? date,
    String? deviceModel,
    String? screenSize,
    double? screenDensity,
    Value<double?> brightnessIfAvailable = const Value.absent(),
    Value<double?> viewingDistance = const Value.absent(),
    String? eyeTested,
    String? correctionUsed,
    String? rawResponsesJson,
    double? score,
    double? accuracy,
    double? reactionTime,
    String? scoringJson,
    String? confidenceJson,
    Value<String?> environmentNotes = const Value.absent(),
  }) => TestResultRow(
    id: id ?? this.id,
    testId: testId ?? this.testId,
    testVersion: testVersion ?? this.testVersion,
    date: date ?? this.date,
    deviceModel: deviceModel ?? this.deviceModel,
    screenSize: screenSize ?? this.screenSize,
    screenDensity: screenDensity ?? this.screenDensity,
    brightnessIfAvailable: brightnessIfAvailable.present
        ? brightnessIfAvailable.value
        : this.brightnessIfAvailable,
    viewingDistance: viewingDistance.present
        ? viewingDistance.value
        : this.viewingDistance,
    eyeTested: eyeTested ?? this.eyeTested,
    correctionUsed: correctionUsed ?? this.correctionUsed,
    rawResponsesJson: rawResponsesJson ?? this.rawResponsesJson,
    score: score ?? this.score,
    accuracy: accuracy ?? this.accuracy,
    reactionTime: reactionTime ?? this.reactionTime,
    scoringJson: scoringJson ?? this.scoringJson,
    confidenceJson: confidenceJson ?? this.confidenceJson,
    environmentNotes: environmentNotes.present
        ? environmentNotes.value
        : this.environmentNotes,
  );
  TestResultRow copyWithCompanion(TestResultsCompanion data) {
    return TestResultRow(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      testVersion: data.testVersion.present
          ? data.testVersion.value
          : this.testVersion,
      date: data.date.present ? data.date.value : this.date,
      deviceModel: data.deviceModel.present
          ? data.deviceModel.value
          : this.deviceModel,
      screenSize: data.screenSize.present
          ? data.screenSize.value
          : this.screenSize,
      screenDensity: data.screenDensity.present
          ? data.screenDensity.value
          : this.screenDensity,
      brightnessIfAvailable: data.brightnessIfAvailable.present
          ? data.brightnessIfAvailable.value
          : this.brightnessIfAvailable,
      viewingDistance: data.viewingDistance.present
          ? data.viewingDistance.value
          : this.viewingDistance,
      eyeTested: data.eyeTested.present ? data.eyeTested.value : this.eyeTested,
      correctionUsed: data.correctionUsed.present
          ? data.correctionUsed.value
          : this.correctionUsed,
      rawResponsesJson: data.rawResponsesJson.present
          ? data.rawResponsesJson.value
          : this.rawResponsesJson,
      score: data.score.present ? data.score.value : this.score,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      reactionTime: data.reactionTime.present
          ? data.reactionTime.value
          : this.reactionTime,
      scoringJson: data.scoringJson.present
          ? data.scoringJson.value
          : this.scoringJson,
      confidenceJson: data.confidenceJson.present
          ? data.confidenceJson.value
          : this.confidenceJson,
      environmentNotes: data.environmentNotes.present
          ? data.environmentNotes.value
          : this.environmentNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestResultRow(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('testVersion: $testVersion, ')
          ..write('date: $date, ')
          ..write('deviceModel: $deviceModel, ')
          ..write('screenSize: $screenSize, ')
          ..write('screenDensity: $screenDensity, ')
          ..write('brightnessIfAvailable: $brightnessIfAvailable, ')
          ..write('viewingDistance: $viewingDistance, ')
          ..write('eyeTested: $eyeTested, ')
          ..write('correctionUsed: $correctionUsed, ')
          ..write('rawResponsesJson: $rawResponsesJson, ')
          ..write('score: $score, ')
          ..write('accuracy: $accuracy, ')
          ..write('reactionTime: $reactionTime, ')
          ..write('scoringJson: $scoringJson, ')
          ..write('confidenceJson: $confidenceJson, ')
          ..write('environmentNotes: $environmentNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    testId,
    testVersion,
    date,
    deviceModel,
    screenSize,
    screenDensity,
    brightnessIfAvailable,
    viewingDistance,
    eyeTested,
    correctionUsed,
    rawResponsesJson,
    score,
    accuracy,
    reactionTime,
    scoringJson,
    confidenceJson,
    environmentNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestResultRow &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.testVersion == this.testVersion &&
          other.date == this.date &&
          other.deviceModel == this.deviceModel &&
          other.screenSize == this.screenSize &&
          other.screenDensity == this.screenDensity &&
          other.brightnessIfAvailable == this.brightnessIfAvailable &&
          other.viewingDistance == this.viewingDistance &&
          other.eyeTested == this.eyeTested &&
          other.correctionUsed == this.correctionUsed &&
          other.rawResponsesJson == this.rawResponsesJson &&
          other.score == this.score &&
          other.accuracy == this.accuracy &&
          other.reactionTime == this.reactionTime &&
          other.scoringJson == this.scoringJson &&
          other.confidenceJson == this.confidenceJson &&
          other.environmentNotes == this.environmentNotes);
}

class TestResultsCompanion extends UpdateCompanion<TestResultRow> {
  final Value<String> id;
  final Value<String> testId;
  final Value<String> testVersion;
  final Value<DateTime> date;
  final Value<String> deviceModel;
  final Value<String> screenSize;
  final Value<double> screenDensity;
  final Value<double?> brightnessIfAvailable;
  final Value<double?> viewingDistance;
  final Value<String> eyeTested;
  final Value<String> correctionUsed;
  final Value<String> rawResponsesJson;
  final Value<double> score;
  final Value<double> accuracy;
  final Value<double> reactionTime;
  final Value<String> scoringJson;
  final Value<String> confidenceJson;
  final Value<String?> environmentNotes;
  final Value<int> rowid;
  const TestResultsCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.testVersion = const Value.absent(),
    this.date = const Value.absent(),
    this.deviceModel = const Value.absent(),
    this.screenSize = const Value.absent(),
    this.screenDensity = const Value.absent(),
    this.brightnessIfAvailable = const Value.absent(),
    this.viewingDistance = const Value.absent(),
    this.eyeTested = const Value.absent(),
    this.correctionUsed = const Value.absent(),
    this.rawResponsesJson = const Value.absent(),
    this.score = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.reactionTime = const Value.absent(),
    this.scoringJson = const Value.absent(),
    this.confidenceJson = const Value.absent(),
    this.environmentNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestResultsCompanion.insert({
    required String id,
    required String testId,
    required String testVersion,
    required DateTime date,
    required String deviceModel,
    required String screenSize,
    required double screenDensity,
    this.brightnessIfAvailable = const Value.absent(),
    this.viewingDistance = const Value.absent(),
    required String eyeTested,
    required String correctionUsed,
    required String rawResponsesJson,
    required double score,
    required double accuracy,
    required double reactionTime,
    required String scoringJson,
    required String confidenceJson,
    this.environmentNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       testId = Value(testId),
       testVersion = Value(testVersion),
       date = Value(date),
       deviceModel = Value(deviceModel),
       screenSize = Value(screenSize),
       screenDensity = Value(screenDensity),
       eyeTested = Value(eyeTested),
       correctionUsed = Value(correctionUsed),
       rawResponsesJson = Value(rawResponsesJson),
       score = Value(score),
       accuracy = Value(accuracy),
       reactionTime = Value(reactionTime),
       scoringJson = Value(scoringJson),
       confidenceJson = Value(confidenceJson);
  static Insertable<TestResultRow> custom({
    Expression<String>? id,
    Expression<String>? testId,
    Expression<String>? testVersion,
    Expression<DateTime>? date,
    Expression<String>? deviceModel,
    Expression<String>? screenSize,
    Expression<double>? screenDensity,
    Expression<double>? brightnessIfAvailable,
    Expression<double>? viewingDistance,
    Expression<String>? eyeTested,
    Expression<String>? correctionUsed,
    Expression<String>? rawResponsesJson,
    Expression<double>? score,
    Expression<double>? accuracy,
    Expression<double>? reactionTime,
    Expression<String>? scoringJson,
    Expression<String>? confidenceJson,
    Expression<String>? environmentNotes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (testVersion != null) 'test_version': testVersion,
      if (date != null) 'date': date,
      if (deviceModel != null) 'device_model': deviceModel,
      if (screenSize != null) 'screen_size': screenSize,
      if (screenDensity != null) 'screen_density': screenDensity,
      if (brightnessIfAvailable != null)
        'brightness_if_available': brightnessIfAvailable,
      if (viewingDistance != null) 'viewing_distance': viewingDistance,
      if (eyeTested != null) 'eye_tested': eyeTested,
      if (correctionUsed != null) 'correction_used': correctionUsed,
      if (rawResponsesJson != null) 'raw_responses_json': rawResponsesJson,
      if (score != null) 'score': score,
      if (accuracy != null) 'accuracy': accuracy,
      if (reactionTime != null) 'reaction_time': reactionTime,
      if (scoringJson != null) 'scoring_json': scoringJson,
      if (confidenceJson != null) 'confidence_json': confidenceJson,
      if (environmentNotes != null) 'environment_notes': environmentNotes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestResultsCompanion copyWith({
    Value<String>? id,
    Value<String>? testId,
    Value<String>? testVersion,
    Value<DateTime>? date,
    Value<String>? deviceModel,
    Value<String>? screenSize,
    Value<double>? screenDensity,
    Value<double?>? brightnessIfAvailable,
    Value<double?>? viewingDistance,
    Value<String>? eyeTested,
    Value<String>? correctionUsed,
    Value<String>? rawResponsesJson,
    Value<double>? score,
    Value<double>? accuracy,
    Value<double>? reactionTime,
    Value<String>? scoringJson,
    Value<String>? confidenceJson,
    Value<String?>? environmentNotes,
    Value<int>? rowid,
  }) {
    return TestResultsCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      testVersion: testVersion ?? this.testVersion,
      date: date ?? this.date,
      deviceModel: deviceModel ?? this.deviceModel,
      screenSize: screenSize ?? this.screenSize,
      screenDensity: screenDensity ?? this.screenDensity,
      brightnessIfAvailable:
          brightnessIfAvailable ?? this.brightnessIfAvailable,
      viewingDistance: viewingDistance ?? this.viewingDistance,
      eyeTested: eyeTested ?? this.eyeTested,
      correctionUsed: correctionUsed ?? this.correctionUsed,
      rawResponsesJson: rawResponsesJson ?? this.rawResponsesJson,
      score: score ?? this.score,
      accuracy: accuracy ?? this.accuracy,
      reactionTime: reactionTime ?? this.reactionTime,
      scoringJson: scoringJson ?? this.scoringJson,
      confidenceJson: confidenceJson ?? this.confidenceJson,
      environmentNotes: environmentNotes ?? this.environmentNotes,
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
    if (testVersion.present) {
      map['test_version'] = Variable<String>(testVersion.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (deviceModel.present) {
      map['device_model'] = Variable<String>(deviceModel.value);
    }
    if (screenSize.present) {
      map['screen_size'] = Variable<String>(screenSize.value);
    }
    if (screenDensity.present) {
      map['screen_density'] = Variable<double>(screenDensity.value);
    }
    if (brightnessIfAvailable.present) {
      map['brightness_if_available'] = Variable<double>(
        brightnessIfAvailable.value,
      );
    }
    if (viewingDistance.present) {
      map['viewing_distance'] = Variable<double>(viewingDistance.value);
    }
    if (eyeTested.present) {
      map['eye_tested'] = Variable<String>(eyeTested.value);
    }
    if (correctionUsed.present) {
      map['correction_used'] = Variable<String>(correctionUsed.value);
    }
    if (rawResponsesJson.present) {
      map['raw_responses_json'] = Variable<String>(rawResponsesJson.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (reactionTime.present) {
      map['reaction_time'] = Variable<double>(reactionTime.value);
    }
    if (scoringJson.present) {
      map['scoring_json'] = Variable<String>(scoringJson.value);
    }
    if (confidenceJson.present) {
      map['confidence_json'] = Variable<String>(confidenceJson.value);
    }
    if (environmentNotes.present) {
      map['environment_notes'] = Variable<String>(environmentNotes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestResultsCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('testVersion: $testVersion, ')
          ..write('date: $date, ')
          ..write('deviceModel: $deviceModel, ')
          ..write('screenSize: $screenSize, ')
          ..write('screenDensity: $screenDensity, ')
          ..write('brightnessIfAvailable: $brightnessIfAvailable, ')
          ..write('viewingDistance: $viewingDistance, ')
          ..write('eyeTested: $eyeTested, ')
          ..write('correctionUsed: $correctionUsed, ')
          ..write('rawResponsesJson: $rawResponsesJson, ')
          ..write('score: $score, ')
          ..write('accuracy: $accuracy, ')
          ..write('reactionTime: $reactionTime, ')
          ..write('scoringJson: $scoringJson, ')
          ..write('confidenceJson: $confidenceJson, ')
          ..write('environmentNotes: $environmentNotes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TestResultsTable testResults = $TestResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [testResults];
}

typedef $$TestResultsTableCreateCompanionBuilder =
    TestResultsCompanion Function({
      required String id,
      required String testId,
      required String testVersion,
      required DateTime date,
      required String deviceModel,
      required String screenSize,
      required double screenDensity,
      Value<double?> brightnessIfAvailable,
      Value<double?> viewingDistance,
      required String eyeTested,
      required String correctionUsed,
      required String rawResponsesJson,
      required double score,
      required double accuracy,
      required double reactionTime,
      required String scoringJson,
      required String confidenceJson,
      Value<String?> environmentNotes,
      Value<int> rowid,
    });
typedef $$TestResultsTableUpdateCompanionBuilder =
    TestResultsCompanion Function({
      Value<String> id,
      Value<String> testId,
      Value<String> testVersion,
      Value<DateTime> date,
      Value<String> deviceModel,
      Value<String> screenSize,
      Value<double> screenDensity,
      Value<double?> brightnessIfAvailable,
      Value<double?> viewingDistance,
      Value<String> eyeTested,
      Value<String> correctionUsed,
      Value<String> rawResponsesJson,
      Value<double> score,
      Value<double> accuracy,
      Value<double> reactionTime,
      Value<String> scoringJson,
      Value<String> confidenceJson,
      Value<String?> environmentNotes,
      Value<int> rowid,
    });

class $$TestResultsTableFilterComposer
    extends Composer<_$AppDatabase, $TestResultsTable> {
  $$TestResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testVersion => $composableBuilder(
    column: $table.testVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screenSize => $composableBuilder(
    column: $table.screenSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get screenDensity => $composableBuilder(
    column: $table.screenDensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brightnessIfAvailable => $composableBuilder(
    column: $table.brightnessIfAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get viewingDistance => $composableBuilder(
    column: $table.viewingDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eyeTested => $composableBuilder(
    column: $table.eyeTested,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctionUsed => $composableBuilder(
    column: $table.correctionUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawResponsesJson => $composableBuilder(
    column: $table.rawResponsesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reactionTime => $composableBuilder(
    column: $table.reactionTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scoringJson => $composableBuilder(
    column: $table.scoringJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidenceJson => $composableBuilder(
    column: $table.confidenceJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get environmentNotes => $composableBuilder(
    column: $table.environmentNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TestResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $TestResultsTable> {
  $$TestResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testVersion => $composableBuilder(
    column: $table.testVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screenSize => $composableBuilder(
    column: $table.screenSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get screenDensity => $composableBuilder(
    column: $table.screenDensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brightnessIfAvailable => $composableBuilder(
    column: $table.brightnessIfAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get viewingDistance => $composableBuilder(
    column: $table.viewingDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eyeTested => $composableBuilder(
    column: $table.eyeTested,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctionUsed => $composableBuilder(
    column: $table.correctionUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawResponsesJson => $composableBuilder(
    column: $table.rawResponsesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reactionTime => $composableBuilder(
    column: $table.reactionTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scoringJson => $composableBuilder(
    column: $table.scoringJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidenceJson => $composableBuilder(
    column: $table.confidenceJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get environmentNotes => $composableBuilder(
    column: $table.environmentNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TestResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestResultsTable> {
  $$TestResultsTableAnnotationComposer({
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

  GeneratedColumn<String> get testVersion => $composableBuilder(
    column: $table.testVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get screenSize => $composableBuilder(
    column: $table.screenSize,
    builder: (column) => column,
  );

  GeneratedColumn<double> get screenDensity => $composableBuilder(
    column: $table.screenDensity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get brightnessIfAvailable => $composableBuilder(
    column: $table.brightnessIfAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<double> get viewingDistance => $composableBuilder(
    column: $table.viewingDistance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eyeTested =>
      $composableBuilder(column: $table.eyeTested, builder: (column) => column);

  GeneratedColumn<String> get correctionUsed => $composableBuilder(
    column: $table.correctionUsed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawResponsesJson => $composableBuilder(
    column: $table.rawResponsesJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get reactionTime => $composableBuilder(
    column: $table.reactionTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scoringJson => $composableBuilder(
    column: $table.scoringJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidenceJson => $composableBuilder(
    column: $table.confidenceJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get environmentNotes => $composableBuilder(
    column: $table.environmentNotes,
    builder: (column) => column,
  );
}

class $$TestResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TestResultsTable,
          TestResultRow,
          $$TestResultsTableFilterComposer,
          $$TestResultsTableOrderingComposer,
          $$TestResultsTableAnnotationComposer,
          $$TestResultsTableCreateCompanionBuilder,
          $$TestResultsTableUpdateCompanionBuilder,
          (
            TestResultRow,
            BaseReferences<_$AppDatabase, $TestResultsTable, TestResultRow>,
          ),
          TestResultRow,
          PrefetchHooks Function()
        > {
  $$TestResultsTableTableManager(_$AppDatabase db, $TestResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<String> testVersion = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> deviceModel = const Value.absent(),
                Value<String> screenSize = const Value.absent(),
                Value<double> screenDensity = const Value.absent(),
                Value<double?> brightnessIfAvailable = const Value.absent(),
                Value<double?> viewingDistance = const Value.absent(),
                Value<String> eyeTested = const Value.absent(),
                Value<String> correctionUsed = const Value.absent(),
                Value<String> rawResponsesJson = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<double> accuracy = const Value.absent(),
                Value<double> reactionTime = const Value.absent(),
                Value<String> scoringJson = const Value.absent(),
                Value<String> confidenceJson = const Value.absent(),
                Value<String?> environmentNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestResultsCompanion(
                id: id,
                testId: testId,
                testVersion: testVersion,
                date: date,
                deviceModel: deviceModel,
                screenSize: screenSize,
                screenDensity: screenDensity,
                brightnessIfAvailable: brightnessIfAvailable,
                viewingDistance: viewingDistance,
                eyeTested: eyeTested,
                correctionUsed: correctionUsed,
                rawResponsesJson: rawResponsesJson,
                score: score,
                accuracy: accuracy,
                reactionTime: reactionTime,
                scoringJson: scoringJson,
                confidenceJson: confidenceJson,
                environmentNotes: environmentNotes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String testId,
                required String testVersion,
                required DateTime date,
                required String deviceModel,
                required String screenSize,
                required double screenDensity,
                Value<double?> brightnessIfAvailable = const Value.absent(),
                Value<double?> viewingDistance = const Value.absent(),
                required String eyeTested,
                required String correctionUsed,
                required String rawResponsesJson,
                required double score,
                required double accuracy,
                required double reactionTime,
                required String scoringJson,
                required String confidenceJson,
                Value<String?> environmentNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestResultsCompanion.insert(
                id: id,
                testId: testId,
                testVersion: testVersion,
                date: date,
                deviceModel: deviceModel,
                screenSize: screenSize,
                screenDensity: screenDensity,
                brightnessIfAvailable: brightnessIfAvailable,
                viewingDistance: viewingDistance,
                eyeTested: eyeTested,
                correctionUsed: correctionUsed,
                rawResponsesJson: rawResponsesJson,
                score: score,
                accuracy: accuracy,
                reactionTime: reactionTime,
                scoringJson: scoringJson,
                confidenceJson: confidenceJson,
                environmentNotes: environmentNotes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TestResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TestResultsTable,
      TestResultRow,
      $$TestResultsTableFilterComposer,
      $$TestResultsTableOrderingComposer,
      $$TestResultsTableAnnotationComposer,
      $$TestResultsTableCreateCompanionBuilder,
      $$TestResultsTableUpdateCompanionBuilder,
      (
        TestResultRow,
        BaseReferences<_$AppDatabase, $TestResultsTable, TestResultRow>,
      ),
      TestResultRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TestResultsTableTableManager get testResults =>
      $$TestResultsTableTableManager(_db, _db.testResults);
}
