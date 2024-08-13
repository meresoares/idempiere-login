import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/organization.dart';
import '../models/role.dart';
import '../models/warehouse.dart';

class ApiService {
  final String _baseUrl = '';

  // Función para obtener el token de autorización en un solo paso
  Future<String> loginOneStep({
    required String username,
    required String password,
    required String clientId,
    required String roleId,
    required String organizationId,
    required String warehouseId,
    required String language,
  }) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/tokens');

    final body = jsonEncode({
      "userName": username,
      "password": password,
      "parameters": {
        "clientId": clientId,
        "roleId": roleId,
        "organizationId": organizationId,
        "warehouseId": warehouseId,
        "language": language
      }
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Retorna el token de autorización
    } else {
      throw Exception('Error al obtener el token de autorización en un solo paso');
    }
  }

  // Función para obtener el token de autorización con login normal
  Future<String> loginNormal({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/tokens');

    final body = jsonEncode({
      "userName": username,
      "password": password
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Retorna el token de autorización
    } else {
      throw Exception('Error al obtener el token de autorización normal');
    }
  }

  // Función para obtener roles usando el token de autorización
  Future<List<Role>> fetchRoles(String token) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/roles');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GetRoles.fromJson(data).roles;
    } else {
      throw Exception('Error al obtener los roles');
    }
  }

  // Función para obtener organizaciones usando el token de autorización
  Future<List<Organization>> fetchOrganizations(String token, String clientId, String roleId) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/organizations?client=$clientId&role=$roleId');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GetOrganizations.fromJson(data).organizations;
    } else {
      throw Exception('Error al obtener las organizaciones');
    }
  }

  // Función para obtener almacenes usando el token de autorización
  Future<List<Warehouse>> fetchWarehouses(String token, String clientId, String roleId, String organizationId) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/warehouses?client=$clientId&role=$roleId&organization=$organizationId');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GetWarehouses.fromJson(data).warehouses;
    } else {
      throw Exception('Error al obtener los almacenes');
    }
  }

  // Función para obtener idiomas usando el token de autorización
  Future<List<String>> fetchLanguages(String token, String clientId) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/language?client=$clientId');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['languages']);
    } else {
      throw Exception('Error al obtener los idiomas');
    }
  }
}
