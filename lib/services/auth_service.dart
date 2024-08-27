import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_flutter/models/client_model.dart';

class AuthService with ChangeNotifier {
  final String _baseUrl = 'http://localhost:3000';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  // Propiedades para almacenar client
  String? _authToken;
  final List<Client> _clients = [];

  String? get authToken => _authToken;
  List<Client> get clients => _clients;

  // Metodo para obtener el token almacenado
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Metodo para guardar el token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    print('Token guardado: $token');
  }

  // Método para eliminar el token
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    print('Token eliminado');
  }

  // Login para usar mobpx
  Future<Map<String, dynamic>> login(String username, String password) async {
  const String endpoint = '/api/v1/auth/tokens';
  final Map<String, dynamic> params = {
    "userName": username,
    "password": password,
  };

  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  final String body = json.encode(params);

  final response = await http.post(
    Uri.parse('$_baseUrl$endpoint'),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));

    // Devuelve tanto el token como los clientes en un Map<String, dynamic>
    return {
      'token': responseData['token'],
      'clients': responseData['clients'],
    };
  } else {
    final Map<String, dynamic> errorData =
        jsonDecode(utf8.decode(response.bodyBytes));
    throw APIException(errorData['detail'], response.statusCode);
  }
}

// Método de login "one-step"
  Future<Map<String, String>> loginOneStep({
    required String username,
    required String password,
    required int clientId,
    required int roleId,
    required int organizationId,
    required int warehouseId,
    required String language,
  }) async {
    const String endpoint = '/auth/tokens';
    final Uri url = Uri.parse('$_baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'userName': username,
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      await saveToken(data['token']);
      return {
        'token': data['token'],
        'refresh_token': data['refresh_token'],
      };
    } else {
      final Map<String, dynamic> errorData =
          jsonDecode(utf8.decode(response.bodyBytes));
      throw APIException(errorData['detail'], response.statusCode);
    }
  }
}

// Método para cerrar sesión
/*Future<void> logout() async {
  const String endpoint = '/api/v1/auth/logout';
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  final String body = json.encode({
    "token": _\authToken,
  });

  final response = await http.post(
    Uri.parse('$_baseUrl$endpoint'),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    await deleteToken();
    _authToken = null;
    notifyListeners();
  } else {
    final Map<String, dynamic> errorData =
        jsonDecode(utf8.decode(response.bodyBytes));
    throw APIException(errorData['detail'], response.statusCode);
  }
} */

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
