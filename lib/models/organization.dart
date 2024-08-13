class Organization {
  Organization({required this.id, required this.name});
  final int id;
  final String name;

  factory Organization.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    return Organization(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GetOrganizations {
  GetOrganizations({required this.organizations});
  final List<Organization> organizations;

  factory GetOrganizations.fromJson(Map<String, dynamic> data) {
    final organizationsData = data['organizations'] as List<dynamic>;
    final organizations = organizationsData
        .map((orgData) => Organization.fromJson(orgData))
        .toList();

    return GetOrganizations(organizations: organizations);
  }
}
