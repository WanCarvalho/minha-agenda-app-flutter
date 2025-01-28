import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';

class ContatoLista extends StatelessWidget {
  final List<Contato> contatos;

  const ContatoLista({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${contatos[index].nome} ${contatos[index].sobrenome}'),
          subtitle: Text(contatos[index].telefone),
        );
      },
    );
  }
}