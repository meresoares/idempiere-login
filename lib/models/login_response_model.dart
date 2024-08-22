import '../models/client_model.dart';

class LoginResponse {
  final String token;
  final List<Client> clients;

  LoginResponse({
    required this.token,
    required this.clients,
  });

  // Método para convertir un JSON en LoginResponse
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      clients: (json['clients'] as List)
          .map((client) => Client.fromJson(client))
          .toList(),
    );
  }
}
