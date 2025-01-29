import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';
import 'package:minha_agenda_app/screens/editar_contato.dart';
import 'package:provider/provider.dart';

class ContatoLista extends StatelessWidget {
  final ContatoStatus? exibirApenas;

  const ContatoLista({this.exibirApenas, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContatoProvider>(
      builder: (context, contatoProvider, child) {
        final contatos = contatoProvider.contatos;

        final contatosFiltrados = exibirApenas == null
            ? contatos
            : Map.fromEntries(
                contatos.entries
                    .where((entry) => entry.value.status == exibirApenas),
              );

        if (contatosFiltrados.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum contato encontrado!',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: contatosFiltrados.length,
          itemBuilder: (context, index) {
            final contato = contatosFiltrados.values.elementAt(index);
            final id = contatosFiltrados.keys.elementAt(index);

            return ListTile(
              title: Text('${contato.nome} ${contato.sobrenome}'),
              subtitle: Text(
                contato.status == ContatoStatus.normal
                    ? contato.telefone
                    : '${contato.telefone}\nStatus: ${contato.status.toString().split('.').last}',
              ),
              isThreeLine: true,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditarContatoScreen(contatoId: id, contato: contato),
                  ),
                );
                contatoProvider.getContatos();
              },
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

                      contatoProvider.atualizarContato(
                        id,
                        contato,
                      );
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

                      contatoProvider.atualizarContato(
                        id,
                        contato,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
