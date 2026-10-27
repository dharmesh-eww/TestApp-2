import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiodataSession {
  BiodataSession._();

  static String title = 'Untitled biodata';
  static String currentId = 'current';
  static String templateName = 'The Classic';
  static Color templateAccent = const Color(0xFFB88A4A);
  static String fullName = '';
  static String dateOfBirth = '';
  static String gender = '';
  static String height = '';
  static String maritalStatus = '';
  static String religion = '';
  static String community = '';
  static String motherTongue = '';
  static String city = '';

  static String fatherName = '';
  static String fatherOccupation = '';
  static String motherName = '';
  static String motherOccupation = '';
  static int brothers = 0;
  static int sisters = 0;
  static String familyType = '';
  static String familyValues = '';
  static String familyBackground = '';

  static String qualification = '';
  static String course = '';
  static String institution = '';
  static String graduationYear = '';
  static String employmentStatus = '';
  static String occupation = '';
  static String company = '';
  static String workLocation = '';
  static String income = '';

  static bool includePartnerPreferences = false;
  static String partnerMinAge = '21';
  static String partnerMaxAge = '35';
  static String partnerHeight = '';
  static String partnerEducation = '';
  static String partnerOccupation = '';
  static String partnerLocation = '';
  static String partnerNotes = '';

  static Uint8List? photoBytes;
  static String phone = '';
  static String email = '';
  static String contactCity = '';
  static bool showPhone = false;
  static bool showEmail = false;

  static bool get hasContent => fullName.trim().isNotEmpty;

  static Map<String, Object?> snapshot() => <String, Object?>{
    'templateName': templateName, 'templateAccent': templateAccent,
    'fullName': fullName, 'dateOfBirth': dateOfBirth, 'gender': gender,
    'height': height, 'maritalStatus': maritalStatus, 'religion': religion,
    'community': community, 'motherTongue': motherTongue, 'city': city,
    'fatherName': fatherName, 'fatherOccupation': fatherOccupation,
    'motherName': motherName, 'motherOccupation': motherOccupation,
    'brothers': brothers, 'sisters': sisters, 'familyType': familyType,
    'familyValues': familyValues, 'familyBackground': familyBackground,
    'qualification': qualification, 'course': course, 'institution': institution,
    'graduationYear': graduationYear, 'employmentStatus': employmentStatus,
    'occupation': occupation, 'company': company, 'workLocation': workLocation,
    'income': income, 'includePartnerPreferences': includePartnerPreferences,
    'partnerMinAge': partnerMinAge, 'partnerMaxAge': partnerMaxAge,
    'partnerHeight': partnerHeight, 'partnerEducation': partnerEducation,
    'partnerOccupation': partnerOccupation, 'partnerLocation': partnerLocation,
    'partnerNotes': partnerNotes, 'photoBytes': photoBytes, 'phone': phone,
    'email': email, 'contactCity': contactCity, 'showPhone': showPhone,
    'showEmail': showEmail,
  };

  static void restore(SavedBiodata item) {
    final data = item.data;
    String stringValue(String key, [String fallback = '']) => data[key] as String? ?? fallback;
    int intValue(String key) => data[key] as int? ?? 0;
    bool boolValue(String key) => data[key] as bool? ?? false;
    templateName = stringValue('templateName', item.templateName);
    templateAccent = data['templateAccent'] as Color? ?? templateAccent;
    title = item.title;
    currentId = item.id;
    fullName = stringValue('fullName', item.fullName);
    dateOfBirth = stringValue('dateOfBirth'); gender = stringValue('gender');
    height = stringValue('height'); maritalStatus = stringValue('maritalStatus');
    religion = stringValue('religion'); community = stringValue('community');
    motherTongue = stringValue('motherTongue'); city = stringValue('city');
    fatherName = stringValue('fatherName'); fatherOccupation = stringValue('fatherOccupation');
    motherName = stringValue('motherName'); motherOccupation = stringValue('motherOccupation');
    brothers = intValue('brothers'); sisters = intValue('sisters');
    familyType = stringValue('familyType'); familyValues = stringValue('familyValues');
    familyBackground = stringValue('familyBackground');
    qualification = stringValue('qualification'); course = stringValue('course');
    institution = stringValue('institution'); graduationYear = stringValue('graduationYear');
    employmentStatus = stringValue('employmentStatus'); occupation = stringValue('occupation');
    company = stringValue('company'); workLocation = stringValue('workLocation');
    income = stringValue('income'); includePartnerPreferences = boolValue('includePartnerPreferences');
    partnerMinAge = stringValue('partnerMinAge', '21'); partnerMaxAge = stringValue('partnerMaxAge', '35');
    partnerHeight = stringValue('partnerHeight'); partnerEducation = stringValue('partnerEducation');
    partnerOccupation = stringValue('partnerOccupation'); partnerLocation = stringValue('partnerLocation');
    partnerNotes = stringValue('partnerNotes'); photoBytes = data['photoBytes'] as Uint8List?;
    phone = stringValue('phone'); email = stringValue('email'); contactCity = stringValue('contactCity');
    showPhone = boolValue('showPhone'); showEmail = boolValue('showEmail');
  }

  static final List<SavedBiodata> saved = <SavedBiodata>[];

  static Future<void> loadSaved() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final raw = preferences.getString('vivah_saved_biodatas');
      if (raw == null || raw.isEmpty) return;
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      final loaded = <SavedBiodata>[];
      for (final row in decoded) {
        if (row is! Map) continue;
        final rawData = row['data'];
        final data = <String, Object?>{};
        if (rawData is Map) {
          rawData.forEach((key, value) {
            final name = key.toString();
            if (name == 'templateAccent' && value is int) {
              data[name] = Color(value);
            } else if (name == 'photoBytes' && value is String && value.isNotEmpty) {
              data[name] = base64Decode(value);
            } else {
              data[name] = value;
            }
          });
        }
        loaded.add(SavedBiodata(
          id: row['id'] as String? ?? 'draft-${DateTime.now().microsecondsSinceEpoch}',
          title: row['title'] as String? ?? 'Untitled biodata',
          updatedAt: DateTime.tryParse(row['updatedAt'] as String? ?? '') ?? DateTime.now(),
          completed: row['completed'] as bool? ?? false,
          templateName: row['templateName'] as String? ?? 'The Classic',
          fullName: row['fullName'] as String? ?? '',
          data: data,
        ));
      }
      saved
        ..clear()
        ..addAll(loaded..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)));
    } catch (_) {
      // Keep the current in-memory list if local storage is unavailable or invalid.
    }
  }

  static Future<void> persistSaved() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final encoded = saved.map((item) => <String, Object?>{
        'id': item.id,
        'title': item.title,
        'updatedAt': item.updatedAt.toIso8601String(),
        'completed': item.completed,
        'templateName': item.templateName,
        'fullName': item.fullName,
        'data': item.data.map((key, value) {
          if (value is Color) return MapEntry(key, value.toARGB32());
          if (value is Uint8List) return MapEntry(key, base64Encode(value));
          return MapEntry(key, value);
        }),
      }).toList();
      await preferences.setString('vivah_saved_biodatas', jsonEncode(encoded));
    } catch (_) {
      // Saving remains usable in memory if the device storage plugin is unavailable.
    }
  }

  static SavedBiodata save({bool completed = false}) {
    SavedBiodata? existing;
    for (final item in saved) { if (item.id == currentId) { existing = item; break; } }
    final item = SavedBiodata(
      id: currentId,
      title: fullName.trim().isEmpty ? title : fullName.trim(),
      updatedAt: DateTime.now(),
      completed: completed,
      templateName: templateName,
      fullName: fullName,
      data: snapshot(),
    );
    if (existing == null) {
      saved.insert(0, item);
    } else {
      saved[saved.indexOf(existing)] = item;
    }
    title = item.title;
    unawaited(persistSaved());
    return item;
  }

  static void resetForNew(String newTemplate, Color accent) {
    title = 'Untitled biodata';
    currentId = 'draft-${DateTime.now().microsecondsSinceEpoch}';
    templateName = newTemplate;
    templateAccent = accent;
    fullName = '';
    dateOfBirth = '';
    gender = '';
    height = '';
    maritalStatus = '';
    religion = '';
    community = '';
    motherTongue = '';
    city = '';
    fatherName = '';
    fatherOccupation = '';
    motherName = '';
    motherOccupation = '';
    brothers = 0;
    sisters = 0;
    familyType = '';
    familyValues = '';
    familyBackground = '';
    qualification = '';
    course = '';
    institution = '';
    graduationYear = '';
    employmentStatus = '';
    occupation = '';
    company = '';
    workLocation = '';
    income = '';
    includePartnerPreferences = false;
    partnerMinAge = '21';
    partnerMaxAge = '35';
    partnerHeight = '';
    partnerEducation = '';
    partnerOccupation = '';
    partnerLocation = '';
    partnerNotes = '';
    photoBytes = null;
    phone = '';
    email = '';
    contactCity = '';
    showPhone = false;
    showEmail = false;
  }
}

class SavedBiodata {
  const SavedBiodata({
    required this.id,
    required this.title,
    required this.updatedAt,
    required this.completed,
    required this.templateName,
    required this.fullName,
    required this.data,
  });

  final String id;
  final String title;
  final DateTime updatedAt;
  final bool completed;
  final String templateName;
  final String fullName;
  final Map<String, Object?> data;

  SavedBiodata copyWith({String? id, String? title, DateTime? updatedAt, bool? completed}) =>
      SavedBiodata(
        id: id ?? this.id,
        title: title ?? this.title,
        updatedAt: updatedAt ?? this.updatedAt,
        completed: completed ?? this.completed,
        templateName: templateName,
        fullName: fullName,
        data: data,
      );
}
