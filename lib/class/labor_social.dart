class LaborSocial{
  LaborSocial(this.id, this.usuario, this.horas, this.documento,this.idUniversitario,this.nombreUsuario);
  final int id;
  final String usuario;
  final int horas;
  final String documento;
  final String nombreUsuario;
  final String idUniversitario;

  LaborSocial.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        usuario = json['usuario'],horas = json["horas"],documento = json["documento"],nombreUsuario = json["nombreUsuario"],idUniversitario= json["idUniversitario"];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'usuario': usuario,
        'horas': horas,
        'documento': documento,
        'nombreUsuario': nombreUsuario,
        'idUniversitario': idUniversitario,
      };
}