import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/service/contato_service.dart';

class ContatoProvider extends ChangeNotifier {
  final Map<String, Contato> _contatos = {};
  final bool _loading = false;
  String _error = '';

  Map<String, Contato> get contatos => _contatos;
  bool get loading => _loading;
  String get error => _error;

  // Função para adicionar um contato
  Future<void> addContato(Contato newContato) async {
    try {
      Map<String, Contato> addedContato =
          await ContatoService.addContato(newContato);

      _contatos[addedContato.keys.first] = newContato;

      notifyListeners();
    } catch (e) {
      _error = 'Erro ao adicionar contato: $e';
      notifyListeners();
    }
  }
}
