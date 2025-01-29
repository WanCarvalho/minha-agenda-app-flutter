import 'package:minha_agenda_app/domain/model/contato_status.dart';

class Contato {
  String nome;
  String sobrenome;
  String telefone;
  String email;
  ContatoStatus status;
  String endereco;
  String avatar;
  String observacao;

  Contato({
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.email,
    this.status = ContatoStatus.normal,
    required this.endereco,
    this.avatar = '',
    this.observacao = '',
  })  : assert(nome.isNotEmpty),
        assert(sobrenome.isNotEmpty),
        assert(telefone.isNotEmpty),
        assert(email.isNotEmpty),
        assert(endereco.isNotEmpty);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'email': email,
      'status': status.toString().split('.').last,
      'endereco': endereco,
      'avatar': avatar,
      'observacao': observacao,
    };
  }

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      telefone: json['telefone'],
      email: json['email'],
      status: ContatoStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ContatoStatus.normal, // Valor padrão caso não encontre
      ),
      endereco: json['endereco'],
      avatar: json['avatar'],
      observacao: json['observacao'],
    );
  }
}
