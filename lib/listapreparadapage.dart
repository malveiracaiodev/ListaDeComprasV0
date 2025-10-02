import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ListaPreparadaPage extends StatefulWidget {
  const ListaPreparadaPage({super.key});

  @override
  State<ListaPreparadaPage> createState() => _ListaPreparadaPageState();
}

InputDecoration campoEstilizado(
    BuildContext context, String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    hintText: 'Digite $label...',
    prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Theme.of(context).cardColor,
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
  );
}

class _ListaPreparadaPageState extends State<ListaPreparadaPage> {
  final TextEditingController produtoCtrl = TextEditingController();
  final TextEditingController quantidadeCtrl = TextEditingController();

  List<Map<String, dynamic>> listaPreparada = [];

  @override
  void initState() {
    super.initState();
    carregarLista();
  }

  void adicionarItem() {
    final produto = produtoCtrl.text.trim();
    final quantidade = int.tryParse(quantidadeCtrl.text) ?? 1;

    if (produto.isEmpty) return;

    setState(() {
      listaPreparada.add({
        "produto": produto,
        "quantidade": quantidade,
      });
    });

    produtoCtrl.clear();
    quantidadeCtrl.clear();
    salvarLista();
  }

  void removerItem(int index) {
    setState(() {
      listaPreparada.removeAt(index);
    });
    salvarLista();
  }

  void salvarLista() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lista_preparada', jsonEncode(listaPreparada));
  }

  void carregarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('lista_preparada');
    if (json != null) {
      setState(() {
        listaPreparada = List<Map<String, dynamic>>.from(jsonDecode(json));
      });
    }
  }

  void irParaModoComprando() {
    if (listaPreparada.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione itens antes de continuar')),
      );
      return;
    }

    final listaFormatada = listaPreparada.map((item) {
      return {
        "produto": item['produto'],
        "quantidade": item['quantidade'],
      };
    }).toList();

    Navigator.pushNamed(
      context,
      '/comprando',
      arguments: listaFormatada,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: produtoCtrl,
                    decoration:
                        campoEstilizado(context, 'Produto', Icons.shopping_bag),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: quantidadeCtrl,
                    decoration: campoEstilizado(context, 'Qtd', Icons.numbers),
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Modo Comprando'),
                    onPressed: irParaModoComprando,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: adicionarItem,
                    child: const Text('Adicionar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: listaPreparada.length,
                itemBuilder: (context, index) {
                  final item = listaPreparada[index];
                  return Card(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.checklist,
                          color: Theme.of(context).colorScheme.primary),
                      title: Text(
                        "${item['produto']} (${item['quantidade']}x)",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removerItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
