class Role {
  Role({required this.id, required this.name});
  final int id;
  final String name;

  factory Role.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    return Role(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GetRoles {
  GetRoles({required this.roles});
  final List<Role> roles;

  factory GetRoles.fromJson(Map<String, dynamic> data) {
    final rolesData = data['roles'] as List<dynamic>;
    final roles = rolesData
        .map((roleData) => Role.fromJson(roleData))
        .toList();

    return GetRoles(roles: roles);
  }
}
