import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/service/contato_service.dart';

class ContatoProvider with ChangeNotifier {
  final Map<String, Contato> _contatos = {};
  final bool _loading = false;
  String _error = '';

  Map<String, Contato> get contatos => this._contatos;
  bool get loading => _loading;
  String get error => _error;

  Future<Map<String, Contato>> getContatos() async {
    try {
      final contatos = await ContatoService.getContatos();
      this._contatos.clear();
      this._contatos.addAll(contatos);
      notifyListeners();
      return this.contatos;
    } catch (error) {
      rethrow;
    }
  }

  Future<MapEntry<String, Contato>> addContato(Contato newContato) async {
    try {
      final addedContato = await ContatoService.addContato(newContato);

      this._contatos[addedContato.key] = addedContato.value;

      notifyListeners();

      return addedContato;
    } catch (e) {
      rethrow;
    }
  }
}
