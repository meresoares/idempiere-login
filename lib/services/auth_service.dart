import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService(this.baseUrl);

  // Método para realizar el login inicial y obtener el token y clientes
  Future<Map<String, dynamic>> login(String userName, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/tokens'),
      body: jsonEncode({
        'userName': userName,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  // Método para obtener roles disponibles
  Future<List<dynamic>> getRoles(String clientId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/auth/roles?client=$clientId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener roles');
    }
  }

  // Otros métodos similares para obtener organizations, warehouses, etc.

  Future<Map<String, dynamic>> finalizeLogin({
    required String token,
    required String clientId,
    required String roleId,
    String? organizationId,
    String? warehouseId,
    String? language,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/v1/auth/tokens'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'clientId': clientId,
        'roleId': roleId,
        'organizationId': organizationId,
        'warehouseId': warehouseId,
        'language': language,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al finalizar la autenticación');
    }
  }
}
