import 'package:flutter/material.dart';
import '../models/empresa.dart';

class TarjetaEmpresa extends StatelessWidget {
  final Empresa empresa;
  final VoidCallback onToggleActiva;
  const TarjetaEmpresa({
    super.key,
    required this.empresa,
    required this.onToggleActiva,
  });

  @override
  Widget build(BuildContext context) {
    final muted = !empresa.activa;
    final colorTexto = muted
        ? const Color.fromARGB(255, 116, 216, 158)
        : const Color.fromARGB(255, 209, 135, 106);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          Icons.apartment,
          color: muted
              ? const Color.fromARGB(255, 170, 40, 196)
              : Theme.of(context).colorScheme.primary,
        ),
        title: Row(
          children: [
            Icon(
              Icons.domain,
              color: muted
                  ? const Color.fromARGB(255, 197, 221, 62)
                  : const Color.fromARGB(255, 37, 75, 82),
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${empresa.nombre} — ${empresa.sector}',
                style: TextStyle(
                  color: colorTexto,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text(empresa.provincia),
                    visualDensity: VisualDensity.compact,
                  ),
                  Chip(
                    label: Text(empresa.tamanyo),
                    visualDensity: VisualDensity.compact,
                  ),
                  Chip(
                    label: Text(empresa.activa ? 'Activa' : 'Inactiva'),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: IconButton(
          tooltip: empresa.activa ? 'Marcar inactiva' : 'Marcar activa',
          icon: Icon(
            empresa.activa ? Icons.toggle_on : Icons.toggle_off,
            size: 32,
          ),
          onPressed: onToggleActiva,
        ),
      ),
    );
  }
}
