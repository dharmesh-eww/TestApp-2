import 'dart:typed_data';

import 'package:flutter/material.dart';

class BiodataSession {
  BiodataSession._();

  static String title = 'Untitled biodata';
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

  static final List<SavedBiodata> saved = <SavedBiodata>[];

  static SavedBiodata save({bool completed = false}) {
    SavedBiodata? existing;
    for (final item in saved) { if (item.id == 'current') { existing = item; break; } }
    final item = SavedBiodata(
      id: 'current',
      title: fullName.trim().isEmpty ? title : fullName.trim(),
      updatedAt: DateTime.now(),
      completed: completed,
      templateName: templateName,
      fullName: fullName,
    );
    if (existing == null) {
      saved.insert(0, item);
    } else {
      saved[saved.indexOf(existing)] = item;
    }
    title = item.title;
    return item;
  }

  static void resetForNew(String newTemplate, Color accent) {
    title = 'Untitled biodata';
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
  });

  final String id;
  final String title;
  final DateTime updatedAt;
  final bool completed;
  final String templateName;
  final String fullName;

  SavedBiodata copyWith({String? id, String? title, DateTime? updatedAt, bool? completed}) =>
      SavedBiodata(
        id: id ?? this.id,
        title: title ?? this.title,
        updatedAt: updatedAt ?? this.updatedAt,
        completed: completed ?? this.completed,
        templateName: templateName,
        fullName: fullName,
      );
}
