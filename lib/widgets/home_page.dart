import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/screens/cadastrar_contato.dart';
import 'package:minha_agenda_app/widgets/contatos/contato_lista.dart';
import 'package:minha_agenda_app/domain/service/contato_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contato> contatos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    try {
      final contatosMap = await ContatoService.getContatos();
      setState(() {
        contatos = contatosMap.values.toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar contatos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Contato> favoritos = contatos
        .where((contato) => contato.status == ContatoStatus.favorito)
        .toList();
    List<Contato> bloqueados = contatos
        .where((contato) => contato.status == ContatoStatus.bloqueado)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Nome: Wanderson Carvalho',
                              style: TextStyle(fontSize: 18)),
                          Text('Matrícula: 20220005950',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Exibe carregamento
          : DefaultTabController(
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
                        ContatoLista(contatos: contatos),
                        ContatoLista(contatos: favoritos),
                        ContatoLista(contatos: bloqueados),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroContatoScreen()),
          );
          _carregarContatos(); // Atualiza a lista após o cadastro
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
