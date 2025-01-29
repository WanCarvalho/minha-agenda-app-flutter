import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';

class CadastroContatoScreen extends StatefulWidget {
  @override
  _CadastroContatoScreenState createState() => _CadastroContatoScreenState();
}

class _CadastroContatoScreenState extends State<CadastroContatoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  ContatoStatus _status = ContatoStatus.normal;

  void _salvarContato() async {
    if (_formKey.currentState?.validate() ?? false) {
      final novoContato = Contato(
        nome: nomeController.text,
        sobrenome: sobrenomeController.text,
        telefone: telefoneController.text,
        email: emailController.text,
        status: _status,
        endereco: enderecoController.text,
        avatar: avatarController.text,
        observacao: observacaoController.text,
      );

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        await ContatoProvider().addContato(novoContato);

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contato salvo com sucesso!')));

        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(
            context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar contato: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: sobrenomeController,
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O sobrenome é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: telefoneController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O telefone é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O email é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O endereço é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: avatarController,
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                ),
                TextFormField(
                  controller: observacaoController,
                  decoration: InputDecoration(labelText: 'Observações'),
                ),
                DropdownButtonFormField<ContatoStatus>(
                  value: _status,
                  onChanged: (ContatoStatus? newValue) {
                    setState(() {
                      _status = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Status'),
                  items: ContatoStatus.values.map((ContatoStatus status) {
                    return DropdownMenuItem<ContatoStatus>(
                      value: status,
                      child: Text(status
                          .toString()
                          .split('.')
                          .last),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _salvarContato,
                  child: Text('Salvar Contato'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
