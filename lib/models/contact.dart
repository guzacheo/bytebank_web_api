class Contact {
  final String name;
  final int accountNumber;
  final int id;

  Contact(this.name, this.accountNumber, this.id);

  //cria um conversor de json para o objeto em questao
  Contact.fromJson(Map<String, dynamic> json)
  // ?? 0 para que o id seja 0, caso for nulo
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() =>{
    'name': name,
    'accountNumber': accountNumber,
  };

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}
