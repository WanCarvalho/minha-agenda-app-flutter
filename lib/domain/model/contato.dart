class Contato {
  final String nome;
  final String sobrenome;
  final String telefone;
  final String email;
  final String status;
  final String endereco;
  final String avatar;
  final String observacao;

  Contato({
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.email,
    required this.status,
    required this.endereco,
    required this.avatar,
    required this.observacao,
  })  : assert(nome.isNotEmpty),
        assert(sobrenome.isNotEmpty),
        assert(telefone.isNotEmpty),
        assert(email.isNotEmpty),
        assert(status.isNotEmpty),
        assert(endereco.isNotEmpty),
        assert(avatar.isNotEmpty),
        assert(observacao.isNotEmpty);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'email': email,
      'status': status,
      'endereco': endereco,
      'avatar': avatar,
      'observacao': observacao,
    };
  }

  Contato.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        sobrenome = json['sobrenome'],
        telefone = json['telefone'],
        email = json['email'],
        status = json['status'],
        endereco = json['endereco'],
        avatar = json['avatar'],
        observacao = json['observacao'];
}
