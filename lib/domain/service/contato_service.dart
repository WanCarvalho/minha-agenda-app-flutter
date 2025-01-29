import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:http/http.dart' as http;
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'dart:convert';

import 'package:minha_agenda_app/utils/urls.dart';

class ContatoService {
  static Future<MapEntry<String, Contato>> addContato(Contato contato) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/contatos.json'),
      body: json.encode(contato.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return MapEntry(data['name'], contato);
    } else {
      throw Exception('Erro ao cadastrar contato');
    }
  }

  static Future<void> atualizarContato(String id, Contato contato) async {
    try {
      final contatoAtual = await getContatoById(id);

      if (contatoAtual.status == contato.status) {
        contato.status = ContatoStatus.normal;
      }

      final response = await http.put(
        Uri.parse('${Urls.BASE_URL}/contatos/$id.json'),
        body: json.encode(contato.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar o contato');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar o contato: $e');
    }
  }

  static Future<Map<String, Contato>> getContatos() async {
    final response =
        await http.get(Uri.parse('${Urls.BASE_URL}/contatos.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Contato> contatoMap = {};

      data.forEach((key, value) {
        contatoMap[key] = Contato.fromJson(value);
      });

      return contatoMap;
    } else {
      throw Exception('Erro ao buscar contatos');
    }
  }

  static Future<Contato> getContatoById(String id) async {
    final response = await http.get(
      Uri.parse('${Urls.BASE_URL}/contatos/$id.json'),
    );

    if (response.statusCode == 200) {
      final contatoData = json.decode(response.body);
      return Contato.fromJson(contatoData);
    } else {
      throw Exception('Erro ao obter o contato');
    }
  }
}
