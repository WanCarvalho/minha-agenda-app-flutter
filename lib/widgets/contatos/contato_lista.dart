import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';
import 'package:provider/provider.dart';

class ContatoLista extends StatelessWidget {
  final Map<String, Contato> contatos;

  const ContatoLista({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        final contato = contatos.values.elementAt(index);
        final id =
            contatos.keys.elementAt(index); // Pegando o ID associado ao contato

        return ListTile(
          title: Text('${contato.nome} ${contato.sobrenome}'),
          subtitle: Text(
              '${contato.telefone}\nStatus: ${contato.status.toString().split('.').last}'),
          isThreeLine: true,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  contato.status == ContatoStatus.favorito
                      ? Icons.star
                      : Icons.star_border,
                  color: contato.status == ContatoStatus.favorito
                      ? Colors.yellow
                      : null,
                ),
                onPressed: () {
                  contato.status = ContatoStatus.favorito;
                  context.read<ContatoProvider>().atualizarContato(id, contato);
                },
              ),
              IconButton(
                icon: Icon(
                  contato.status == ContatoStatus.bloqueado
                      ? Icons.block
                      : Icons.lock_open,
                  color: contato.status == ContatoStatus.bloqueado
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  contato.status = ContatoStatus.bloqueado;
                  context.read<ContatoProvider>().atualizarContato(id, contato);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
