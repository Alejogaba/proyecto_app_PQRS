class Dependencia {
  String email;
  String jefeOficina;
  String nombre;
  String tel;
  String uid;
  int index;
  String enlace;

  Dependencia({
    required this.email,
    required this.jefeOficina,
    required this.nombre,
    required this.tel,
    this.uid = '',
    this.index = 0,
    this.enlace = '',
  });

  factory Dependencia.fromMap(Map<String, dynamic> map) {
    return Dependencia(
      email: map['email'],
      jefeOficina: map['jefeOficina'],
      nombre: map['nombre'],
      tel: map['tel'],
      uid: map['uid'] ?? '',
      index: map['index'] ?? 0,
      enlace: map['enlace'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'jefeOficina': jefeOficina,
      'nombre': nombre,
      'tel': tel,
      'uid': uid,
      'index': index,
      'enlace': enlace,
    };
  }
}
