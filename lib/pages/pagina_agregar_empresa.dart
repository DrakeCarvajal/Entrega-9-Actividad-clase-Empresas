import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/empresa_provider.dart';
import '../models/empresa.dart';

class PaginaAgregarEmpresa extends StatefulWidget {
  const PaginaAgregarEmpresa({super.key});

  @override
  State<PaginaAgregarEmpresa> createState() => _PaginaAgregarEmpresaState();
}

class _PaginaAgregarEmpresaState extends State<PaginaAgregarEmpresa> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nombreCtrl = TextEditingController();
  String _sector = 'Sector de Tecnología';
  String _provincia = 'Valencia';
  String _tamanyo = 'Pyme';

  @override
  void dispose() {
    _idCtrl.dispose();
    _nombreCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EmpresaProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar empresa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Identificación de empresa (entero)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Introduce un id';
                  final n = int.tryParse(v);
                  if (n == null) return 'Debe ser un número entero';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la empresa',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Introduce un nombre' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Sector', border: OutlineInputBorder()),
                      value: _sector,
                      items: provider.sectores.where((e) => e != 'Todos').map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() => _sector = v ?? _sector),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Provincia', border: OutlineInputBorder()),
                      value: _provincia,
                      items: provider.provincias.where((e) => e != 'Todas las provincias de la Comunidad Valenciana').map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() => _provincia = v ?? _provincia),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tamaño', border: OutlineInputBorder()),
                value: _tamanyo,
                items: provider.tamanos.where((e) => e != 'Todos').map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _tamanyo = v ?? _tamanyo),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar empresa'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final id = int.parse(_idCtrl.text.trim());
                      provider.agregarEmpresa(Empresa(
                        id: id,
                        nombre: _nombreCtrl.text.trim(),
                        sector: _sector,
                        provincia: _provincia,
                        tamanyo: _tamanyo,
                      ));
                      if (mounted) Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
