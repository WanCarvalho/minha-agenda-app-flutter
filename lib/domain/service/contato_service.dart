import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:minha_agenda_app/utils/urls.dart';

class ContatoService {
  static Future<Map<String, Contato>> addContato(Contato contato) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/contatos.json'),
      body: json.encode(contato),
    );

    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      final Map<String, Contato> contatoMap = {id: contato};
      return contatoMap;
    } else {
      throw Exception('Erro ao cadastrar contato.');
    }
  }
}
