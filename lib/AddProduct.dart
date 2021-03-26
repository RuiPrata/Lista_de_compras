import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:image_picker/image_picker.dart';

import 'Produto.dart';



class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  _openGallary(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future <void>_showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice!"),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallary"),
                  onTap: (){
                    _openGallary(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),

                GestureDetector(
                  child: Text("Camera"),
                  onTap: (){
                    _openCamera(context);
                  },
                )
              ],
            )
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text("No image selected");
    }else{
      imagem = Image.file(imageFile,width: 50, height: 50);
      return imagem;
    }
  }






  final TextEditingController _Nome = TextEditingController();
  final TextEditingController _Quantidade = TextEditingController();
  final TextEditingController _precoUnitario = TextEditingController();
  final TextEditingController _observacoes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Adicionar Novo Produto'),
          ),
          bottomNavigationBar: BottomAppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _Nome ,
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      icon: Icon(Icons.add_shopping_cart)
                  ),
                  keyboardType: TextInputType.text,

                ),
                Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: _Quantidade,
                    decoration: InputDecoration(
                        labelText: 'Quantidade',
                        icon: Icon(Icons.format_list_numbered)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: _precoUnitario,
                    decoration: InputDecoration(
                        labelText: 'Preço p/ Unidade',
                        icon: Icon(Icons.euro_symbol)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: _observacoes,
                    decoration: InputDecoration(
                        labelText: 'Observaçoes',
                        icon: Icon(Icons.message)
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _decideImageView(),
                        RaisedButton(onPressed:() {
                          _showChoiceDialog (context);
                        },
                          child: Text("Select Image!"),)
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top:70.0),
                  child: RaisedButton(
                    child: Text('Adicionar Produto'),
                    onPressed: () {
                      final String nome = _Nome.text;
                      final int quantidade = int.tryParse(_Quantidade.text);
                      final double preco = double.tryParse(_precoUnitario.text);
                      final String observacoes = _observacoes.text;

                      if(nome != null && quantidade != null && preco != null && observacoes!= null){
                        final Produto newProduto = Produto(imagem,nome,quantidade,preco,observacoes);

                        if(locked == true){
                          listaProduto.add(newProduto);
                        }else{
                          listaProduto[qq].nome = nome;
                          listaProduto[qq].quantidade = quantidade;
                          listaProduto[qq].precoUnitario = preco;
                          listaProduto[qq].observacoes = observacoes;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      }

                    },
                  ),
                )
              ],
            ),
          ) ,

        )
    );
  }
}