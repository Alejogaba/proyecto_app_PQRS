class Dependencia {
  String email;
  String jefeOficina;
  String nombre;
  String tel;
  String uid;

  Dependencia({
    required this.email,
    required this.jefeOficina,
    required this.nombre,
    required this.tel,
    this.uid='',
  });

  factory Dependencia.fromMap(Map<String, dynamic> map) {
    return Dependencia(
      email: map['email'],
      jefeOficina: map['jefeOficina'],
      nombre: map['nombre'],
      tel: map['tel'],
      uid: map['uid']??'',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'jefeOficina': jefeOficina,
      'nombre': nombre,
      'tel': tel,
      'uid': uid,
    };
  }
}
