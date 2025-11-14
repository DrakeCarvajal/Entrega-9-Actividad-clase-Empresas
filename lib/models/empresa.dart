// Modelo de Empresa
class Empresa {
  final int id;
  final String nombre;
  final String sector;     // Tecnología, Salud, Educación, Industria
  final String provincia;  // Castellón, Valencia, Alicante
  final String tamanyo;    // Micro, Pyme, Grande
  final bool activa;       // Activa/Inactiva

  Empresa({
    required this.id,
    required this.nombre,
    required this.sector,
    required this.provincia,
    required this.tamanyo,
    this.activa = true,
  });

  Empresa copyWith({
    int? id,
    String? nombre,
    String? sector,
    String? provincia,
    String? tamanyo,
    bool? activa,
  }) => Empresa(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        sector: sector ?? this.sector,
        provincia: provincia ?? this.provincia,
        tamanyo: tamanyo ?? this.tamanyo,
        activa: activa ?? this.activa,
      );
}
