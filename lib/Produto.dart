import 'dart:ui';

import 'package:flutter/material.dart';

class Produto{

  Image image;
  String nome;
  int quantidade = 0;
  double precoUnitario = 0.0;
  int precoTotal;
  String observacoes;
  Color cor = Colors.white;

  double precoFinal(){
    return this.precoUnitario * this.quantidade ;
  }


  Produto(this.image,this.nome,this.quantidade,this.precoUnitario,this.observacoes);
}