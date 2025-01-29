import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/screens/cadastro_contato.dart';
import 'package:minha_agenda_app/widgets/contatos/contato_lista.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContatoProvider>().getContatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                builder: (context) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nome: Wanderson Carvalho',
                            style: TextStyle(fontSize: 18)),
                        Text('Matrícula: 20220005950',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: Consumer<ContatoProvider>(
        builder: (context, contatoProvider, child) {
          if (contatoProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Todos'),
                    Tab(text: 'Favoritos'),
                    Tab(text: 'Bloqueados'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ContatoLista(), // Lista todos os contatos
                      ContatoLista(exibirApenas: ContatoStatus.favorito),
                      ContatoLista(exibirApenas: ContatoStatus.bloqueado),
                    ],
                  ),
                ),
              ],
            ),
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
}
