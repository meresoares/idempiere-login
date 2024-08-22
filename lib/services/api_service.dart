import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_flutter/models/language_model.dart';
import '../models/organization_model.dart';
import '../models/role_model.dart';
import '../models/warehouse_model.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:3000';

  Future<List<Role>> fetchRoles(String authToken, String clientId) async {
    final String endpoint = '/api/v1/auth/roles?client=$clientId';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // Verifica si `data` es un objeto que contiene una lista de roles
      if (data is Map<String, dynamic> && data.containsKey('roles')) {
        // Asumiendo que los roles están en una clave llamada "roles"
        return (data['roles'] as List<dynamic>)
            .map((json) => Role.fromJson(json))
            .toList();
      } else if (data is List) {
        // Los roles están directamente en la lista
        return data.map((json) => Role.fromJson(json)).toList();
      } else {
        throw APIException('Estructura inesperada en la respuesta de roles',
            response.statusCode);
      }
    } else {
      throw APIException('Error al obtener roles api', response.statusCode);
    }
    /* if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => Role.fromJson(json)).toList();
    } else {
      throw APIException('Error al obtener roles', response.statusCode);
    } */
  }

//Future<List<Organization>>
  Future<List<Organization>> fetchOrganizations(
      String authToken, String clientId, String roleId) async {
    final String endpoint =
        '/api/v1/auth/organizations?client=$clientId&role=$roleId';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Decodificar la respuesta como un Map
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));

      // Verificar si 'organizations' es una lista dentro del Map
      if (data['organizations'] is List) {
        final List<dynamic> organizationsData = data['organizations'];

        // Convertir la lista a List<Organization>
        return organizationsData
            .map((json) => Organization.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw APIException(
            'Error al obtener organizaciones', response.statusCode);
      }
    } else {
      throw APIException(
          'Error al obtener organizaciones', response.statusCode);
    }
  }

  Future<List<Warehouse>> fetchWarehouses(String authToken, String clientId,
      String roleId, String organizationId) async {
    final String endpoint =
        '/api/v1/auth/warehouses?client=$clientId&role=$roleId&organization=$organizationId';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON y extrae la lista de almacenes
      final Map<String, dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));

      print('Client ID: $clientId');
      print('Role ID: $roleId');
      print('Organization ID: $organizationId');

      // Asegúrate de que la clave 'warehouses' existe en el mapa
      if (responseData.containsKey('warehouses')) {
        final List<dynamic> warehouseData = responseData['warehouses'];

        // Mapea los datos a la lista de objetos Warehouse
        return warehouseData.map((json) => Warehouse.fromJson(json)).toList();
      } else {
        // Si no hay almacenes, devuelve una lista vacía
        return [];
      }
    } else {
      throw APIException('Error al obtener almacenes', response.statusCode);
    }
  }

  Future<List<Language>> fetchLanguages(
      String authToken, String clientId) async {
    final String endpoint = '/api/v1/auth/language?client=$clientId';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      /* final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<Language> languages = data.entries.map((entry) {
        return Language({'Name': entry.value});
      }).toList();

      return languages; */
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));

      // Verifica si el mapa contiene la clave esperada
      if (data.containsKey('AD_Language') && data['AD_Language'] != null) {
        final String languageString = data['AD_Language'] as String;
        // Crea una lista de Language a partir del string
         return [Language({'AD_Language': languageString})];
      } else {
        return []; // Retorna una lista vacía si no se encuentran datos
      }
    } else {
      throw APIException('Error al obtener lenguajes', response.statusCode);
    }
  }

  // Login normal
  Future<String> login({
    required String username,
    required String password,
  }) async {
    const String endpoint = '/api/v1/auth/tokens';
    final Uri url = Uri.parse('$_baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'userName': username,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String token = data['token'];
      // await saveToken(token);
      return token;
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      throw Exception('Failed to login: ${errorData['detail']}');
    }
  }

  // Login One-Step
  Future<Map<String, String>> loginOneStep({
    required String userName,
    required String password,
    required int clientId,
    required int roleId,
    required int organizationId,
    required int warehouseId,
    required String language,
  }) async {
    final url = Uri.parse('$_baseUrl/tokens');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userName': userName,
      'password': password,
      'parameters': {
        'clientId': clientId,
        'roleId': roleId,
        'organizationId': organizationId,
        'warehouseId': warehouseId,
        'language': language,
      },
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'refresh_token': data['refresh_token'],
      };
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }

  Future<void> finalLogin({
    required String authToken,
    required int clientId,
    required int roleId,
    required int organizationId,
    required int warehouseId,
    required String language,
  }) async {
    const String endpoint = '/api/v1/auth/tokens';
    final Map<String, dynamic> params = {
      'clientId': clientId,
      'roleId': roleId,
      'organizationId': organizationId,
      'warehouseId': warehouseId,
      'language': language,
    };

    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    final String body = json.encode(params);

    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> errorData =
          jsonDecode(utf8.decode(response.bodyBytes));
      throw APIException(errorData['detail'], response.statusCode);
    }
  }

  // Refresh Token
  Future<Map<String, String>> refreshToken(String refreshToken) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/refresh');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'refresh_token': refreshToken,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'refresh_token': data['refresh_token'],
      };
    } else {
      throw Exception('Error al refrescar el token: ${response.body}');
    }
  }
}

// Definición de APIException
class APIException implements Exception {
  final String message;
  final int statusCode;

  APIException(this.message, this.statusCode);

  @override
  String toString() {
    return 'APIException: $message (status code: $statusCode)';
  }
}
