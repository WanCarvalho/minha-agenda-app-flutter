import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/widgets/contatos/contato_lista.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Contato> contatos = [
    Contato(
        nome: 'João',
        sobrenome: "Carvalho",
        telefone: '(84) 99988-7766',
        email: "joao@teste.com",
        endereco: "Endereco",
        avatar: "Avatar",
        observacao: "Observacao"),
  ];

  @override
  Widget build(BuildContext context) {
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
      body: DefaultTabController(
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de adicionar contato
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
