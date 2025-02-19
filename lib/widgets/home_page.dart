import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/screens/cadastro_contato.dart';
import 'package:minha_agenda_app/screens/gerencia_contato.dart';
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

  void _mostrarInformacoesAluno() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informações do Aluno'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: Wanderson Carvalho'),
              Text('Matrícula: 20220005950'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _mostrarInformacoesAluno,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Minha Agenda',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Gerência de Contatos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GerenciaContatosScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Consumer<ContatoProvider>(
        builder: (context, contatoProvider, child) {
          if (contatoProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
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
