import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';
import 'package:minha_agenda_app/domain/provider/contato_provider.dart';

class EditarContatoScreen extends StatefulWidget {
  final String? contatoId;
  final Contato? contato;

  const EditarContatoScreen({super.key, this.contatoId, this.contato});

  @override
  _EditarContatoScreenState createState() => _EditarContatoScreenState();
}

class _EditarContatoScreenState extends State<EditarContatoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomeController;
  late TextEditingController sobrenomeController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;
  late TextEditingController enderecoController;
  late TextEditingController avatarController;
  late TextEditingController observacaoController;

  late ContatoStatus _status;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.contato?.nome ?? '');
    sobrenomeController =
        TextEditingController(text: widget.contato?.sobrenome ?? '');
    telefoneController =
        TextEditingController(text: widget.contato?.telefone ?? '');
    emailController = TextEditingController(text: widget.contato?.email ?? '');
    enderecoController =
        TextEditingController(text: widget.contato?.endereco ?? '');
    avatarController =
        TextEditingController(text: widget.contato?.avatar ?? '');
    observacaoController =
        TextEditingController(text: widget.contato?.observacao ?? '');
    _status = widget.contato?.status ?? ContatoStatus.normal;
  }

  @override
  void dispose() {
    nomeController.dispose();
    sobrenomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    avatarController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  void _atualizarContato() async {
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
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        await ContatoProvider().atualizarContato(widget.contatoId!, novoContato);

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contato atualizado com sucesso!'),
          ),
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar contato: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditando = widget.contatoId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditando ? 'Editar Contato' : 'Cadastrar Contato'),
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
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'O nome é obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: sobrenomeController,
                  decoration: const InputDecoration(labelText: 'Sobrenome'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'O sobrenome é obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: telefoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'O telefone é obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'O email é obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(labelText: 'Endereço'),
                ),
                TextFormField(
                  controller: avatarController,
                  decoration: const InputDecoration(labelText: 'URL do Avatar'),
                ),
                TextFormField(
                  controller: observacaoController,
                  decoration: const InputDecoration(labelText: 'Observações'),
                ),
                DropdownButtonFormField<ContatoStatus>(
                  value: _status,
                  onChanged: (ContatoStatus? newValue) {
                    setState(() {
                      _status = newValue!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: ContatoStatus.values.map((ContatoStatus status) {
                    return DropdownMenuItem<ContatoStatus>(
                      value: status,
                      child: Text(status.toString().split('.').last),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _atualizarContato,
                  child: const Text('Atualizar Contato'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
