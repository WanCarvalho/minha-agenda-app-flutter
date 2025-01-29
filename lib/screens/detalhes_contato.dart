import 'package:flutter/material.dart';
import 'package:minha_agenda_app/domain/model/contato.dart';
import 'package:minha_agenda_app/domain/model/contato_status.dart';

class DetalhesContatoScreen extends StatelessWidget {
  final String? contatoId;
  final Contato? contato;

  const DetalhesContatoScreen({super.key, this.contatoId, this.contato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildInfoTile('Nome', contato?.nome)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildInfoTile('Sobrenome', contato?.sobrenome)),
                ],
              ),
              _buildInfoTile('Email', contato?.email),
              _buildInfoTile('Telefone', contato?.telefone),
              _buildInfoTile('Endereço', contato?.endereco),
              _buildInfoTile('URL do Avatar', contato?.avatar),
              _buildInfoTile('Observações', contato?.observacao),
              _buildInfoTile(
                'Status',
                contato?.status == ContatoStatus.normal
                    ? 'Normal'
                    : contato?.status.toString().split('.').last,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value?.isNotEmpty == true ? value! : 'Não informado',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
