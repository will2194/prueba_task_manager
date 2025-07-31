import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/countries/ui/provider.dart';

class CountryView extends ConsumerWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(countryViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Países")),
      body: countries.when(
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => ListTile(
            title: Text("${list[i].name} (${list[i].code})"),
            subtitle: Text(list[i].capital ?? ""),
            trailing: Text(list[i].emoji),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
