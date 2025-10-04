import 'package:flutter/material.dart';

class ListaProvider extends ChangeNotifier {
  List<String> listaPreparada = [];
  List<String> listaComprando = [];
  List<String> historico = [];

  void adicionarItemPreparado(String item) {
    listaPreparada.add(item);
    notifyListeners();
  }

  void moverParaComprando() {
    listaComprando = List.from(listaPreparada);
    listaPreparada.clear();
    notifyListeners();
  }

  void finalizarCompra() {
    historico.addAll(listaComprando);
    listaComprando.clear();
    notifyListeners();
  }

  void editarHistorico(int index, String novoItem) {
    if (index >= 0 && index < historico.length) {
      historico[index] = novoItem;
      notifyListeners();
    }
  }

  void removerDoHistorico(int index) {
    if (index >= 0 && index < historico.length) {
      historico.removeAt(index);
      notifyListeners();
    }
  }
}
