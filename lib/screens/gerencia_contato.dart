import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';
import 'package:minha_agenda_app/screens/cadastro_contato.dart';
import 'package:minha_agenda_app/screens/editar_contato.dart';
import 'package:provider/provider.dart';

class GerenciaContatosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerência de Contatos')),
      body: Consumer<ContatoProvider>(
        builder: (context, contatoProvider, child) {
          if (contatoProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final contatos = contatoProvider.contatos;

          if (contatos.isEmpty) {
            return const Center(child: Text('Nenhum contato encontrado.'));
          }

          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final id = contatos.keys.elementAt(index);
              final contato = contatos[id]!;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text('${contato.nome} ${contato.sobrenome}'),
                  subtitle: Text(contato.telefone),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarContatoScreen(
                                  contatoId: id, contato: contato),
                            ),
                          );
                          context.read<ContatoProvider>().getContatos();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmarExclusao(context, id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroContatoScreen()),
          );
          context.read<ContatoProvider>().getContatos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, String contatoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Contato'),
        content: const Text('Tem certeza que deseja remover este contato?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<ContatoProvider>().removerContato(contatoId);
              Navigator.pop(context);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
