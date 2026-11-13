class BiodataFieldModel {
  String id;
  String label;
  String value;
  final bool canDelete;
  final bool canEditLabel;

  BiodataFieldModel({required this.id, required this.label, this.value = '', this.canDelete = true, this.canEditLabel = true});

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id, 'label': label, 'value': value,
    'canDelete': canDelete, 'canEditLabel': canEditLabel,
  };

  factory BiodataFieldModel.fromJson(Map<String, dynamic> json) => BiodataFieldModel(
    id: json['id'] as String? ?? 'field-unknown',
    label: json['label'] as String? ?? 'Details',
    value: json['value'] as String? ?? '',
    canDelete: json['canDelete'] as bool? ?? true,
    canEditLabel: json['canEditLabel'] as bool? ?? true,
  );
}

class BiodataSectionModel {
  String id;
  String title;
  final bool canDelete;
  List<BiodataFieldModel> fields;

  BiodataSectionModel({required this.id, required this.title, this.canDelete = true, required this.fields});

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id, 'title': title, 'canDelete': canDelete,
    'fields': fields.map((field) => field.toJson()).toList(),
  };

  factory BiodataSectionModel.fromJson(Map<String, dynamic> json) => BiodataSectionModel(
    id: json['id'] as String? ?? 'section-unknown',
    title: json['title'] as String? ?? 'Details',
    canDelete: json['canDelete'] as bool? ?? true,
    fields: (json['fields'] as List? ?? const []).whereType<Map>()
        .map((field) => BiodataFieldModel.fromJson(Map<String, dynamic>.from(field))).toList(),
  );

  static List<BiodataSectionModel> getInitialSections() => [
    BiodataSectionModel(id: 'personal_details', title: 'Personal Details', canDelete: false, fields: [
      BiodataFieldModel(id: 'p_name', label: 'Full Name', canDelete: false),
      BiodataFieldModel(id: 'p_dob', label: 'Date of Birth'),
      BiodataFieldModel(id: 'p_gender', label: 'Gender'),
      BiodataFieldModel(id: 'p_height', label: 'Height'),
      BiodataFieldModel(id: 'p_weight', label: 'Weight'),
      BiodataFieldModel(id: 'p_marital', label: 'Marital Status'),
      BiodataFieldModel(id: 'p_religion', label: 'Religion'),
      BiodataFieldModel(id: 'p_caste', label: 'Caste / Sub-caste'),
      BiodataFieldModel(id: 'p_mother_tongue', label: 'Mother Tongue'),
      BiodataFieldModel(id: 'p_city', label: 'Current City'),
      BiodataFieldModel(id: 'p_blood_group', label: 'Blood Group'),
    ]),
    BiodataSectionModel(id: 'family_details', title: 'Family Details', fields: [
      BiodataFieldModel(id: 'f_father_name', label: 'Father Name'),
      BiodataFieldModel(id: 'f_father_occupation', label: 'Father Occupation'),
      BiodataFieldModel(id: 'f_mother_name', label: 'Mother Name'),
      BiodataFieldModel(id: 'f_mother_occupation', label: 'Mother Occupation'),
      BiodataFieldModel(id: 'f_brother', label: 'Brother(s)'),
      BiodataFieldModel(id: 'f_sister', label: 'Sister(s)'),
      BiodataFieldModel(id: 'f_family_type', label: 'Family Type'),
      BiodataFieldModel(id: 'f_family_values', label: 'Family Values'),
      BiodataFieldModel(id: 'f_background', label: 'About Family'),
    ]),
    BiodataSectionModel(id: 'education_career', title: 'Education & Career', fields: [
      BiodataFieldModel(id: 'e_qualification', label: 'Qualification'),
      BiodataFieldModel(id: 'e_course', label: 'Course / Specialization'),
      BiodataFieldModel(id: 'e_institution', label: 'Institution'),
      BiodataFieldModel(id: 'e_graduation_year', label: 'Graduation Year'),
      BiodataFieldModel(id: 'e_employment', label: 'Employment Status'),
      BiodataFieldModel(id: 'e_occupation', label: 'Occupation'),
      BiodataFieldModel(id: 'e_company', label: 'Organization'),
      BiodataFieldModel(id: 'e_work_location', label: 'Work Location'),
      BiodataFieldModel(id: 'e_income', label: 'Annual Income'),
    ]),
    BiodataSectionModel(id: 'partner_preferences', title: 'Partner Preferences', fields: [
      BiodataFieldModel(id: 'pp_age', label: 'Preferred Age Range'),
      BiodataFieldModel(id: 'pp_height', label: 'Preferred Height'),
      BiodataFieldModel(id: 'pp_education', label: 'Preferred Education'),
      BiodataFieldModel(id: 'pp_occupation', label: 'Preferred Occupation'),
      BiodataFieldModel(id: 'pp_location', label: 'Preferred Location'),
      BiodataFieldModel(id: 'pp_notes', label: 'Other Preferences'),
    ]),
    BiodataSectionModel(id: 'photo_contact', title: 'Photo & Contact', fields: [
      BiodataFieldModel(id: 'c_phone', label: 'Phone Number'),
      BiodataFieldModel(id: 'c_email', label: 'Email Address'),
      BiodataFieldModel(id: 'c_city', label: 'Contact City'),
    ]),
  ];
}
