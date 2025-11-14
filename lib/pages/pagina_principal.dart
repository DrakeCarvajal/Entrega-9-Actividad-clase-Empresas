import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/empresa_provider.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/tarjeta_empresa.dart';

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EmpresaProvider>();
    final empresas = provider.empresasFiltradas;

    DropdownButton<String> _buildDD({
      required String value,
      required List<String> items,
      required ValueChanged<String> onChanged,
    }) {
      return DropdownButton<String>(
        value: value,
        isDense: true,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      );
    }

    return CustomScaffold(
      //title: 'Empresas CV (Actividad 7)',
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Sector: '),
                    _buildDD(
                      value: provider.filtroSector,
                      items: provider.sectores,
                      onChanged: provider.cambiarFiltroSector,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Provincia: '),
                    _buildDD(
                      value: provider.filtroProvincia,
                      items: provider.provincias,
                      onChanged: provider.cambiarFiltroProvincia,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Tamaño: '),
                    _buildDD(
                      value: provider.filtroTamanyo,
                      items: provider.tamanos,
                      onChanged: provider.cambiarFiltroTamanyo,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Estado: '),
                    _buildDD(
                      value: provider.filtroEstado,
                      items: provider.estados,
                      onChanged: provider.cambiarFiltroEstado,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: empresas.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      itemCount: empresas.length,
                      itemBuilder: (ctx, i) => TarjetaEmpresa(
                        empresa: empresas[i],
                        onToggleActiva: () =>
                            provider.alternarActiva(empresas[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/agregar'),
        icon: const Icon(Icons.add_business),
        label: const Text('Nueva empresa'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.business_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 8),
          Text(
            'No hay empresas que coincidan con los filtros',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
