
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutterapp/AddProduct.dart';
import 'package:flutterapp/shake.dart';


import 'Produto.dart';

void main() => runApp(MyApp());

List<Produto> listaProduto = [
  Produto(
    Image.asset('lib/assets/tomate.jpg'),
      "tomates",
      3,
      3,
      'bla bla bla'
  )
];
int tag = 1;
File  imageFile;
int index;
Image imagem;
int qq;
bool locked= true;


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shopping List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage>{

  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        listaProduto.clear();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Text('Numero de Produtos:'+numProd().toString()+'\nPreço Total:'+ precoApagar().toString()+'€',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.5,
            maxLines: 2,
          ),
        ) ,
      ),
      body:ListView.separated(
          shrinkWrap: true,
          itemCount: listaProduto.length, //tamanho da lista
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: ( direction){
                if(direction == DismissDirection.startToEnd){//swipe right - remove da lista

                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("O artigo "+ listaProduto[index].nome+" foi removido da lista com sucesso")));

                  setState(() {
                    listaProduto.removeAt(index);
                  });

                }else{
                  if(direction == DismissDirection.endToStart){//swipe left -compra
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("O artigo "+ listaProduto[index].nome+" foi comprado com sucesso")));
                    setState(() {
                      listaProduto[index].cor = Colors.green;
                    });

                  }
                }
              },
              background: slideLeftBackground(),
              secondaryBackground: slideRightBackground(),
              child: Container(
                color: listaProduto[index].cor,
                child: Card(
                  child: ListTile(
                    title: Text(listaProduto[index].nome),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    leading:  listaProduto[index].image,
                    subtitle: Text("Quantidade: " + listaProduto[index].quantidade.toString() + " | " +"preco: " + listaProduto[index].precoFinal().toString() + "€"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.black,),
                          onPressed: ()=> _decrementarProd(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.black,),
                          onPressed: ()=> _incrementarProd(index),
                        )
                      ],
                    ),
                    onTap: () {
                      qq=index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDescription()),
                      );
                    },
                  ),
                ),
              ),
            );

          },
        ),

      floatingActionButton: FloatingActionButton(
        heroTag: 0,
        child: Icon(Icons.add),
        onPressed: (){
          locked = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
      ),
    );
  }
  void _decrementarProd(int index){
    setState(() {
      if (listaProduto[index].quantidade > 0) {
        listaProduto[index].quantidade--;
      } else {
        listaProduto[index].quantidade = 0;
      }
    }
    );
  }

  void _incrementarProd(int index){
    setState(() {
      listaProduto[index].quantidade++;
    });

  }

  int numProd() {
    int numeroProd = 0;
      for (int i = 0; i < listaProduto.length; i++) {
        numeroProd += listaProduto[i].quantidade;
      }
      return numeroProd;
  }

  double precoApagar(){
    double preco=0.0;
    for(int i= 0;i<listaProduto.length;i++){
      preco += listaProduto[i].precoFinal().ceil();
    }
    return preco;
  }
}

Widget slideRightBackground(){
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(

        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Icon(
            Icons.check,
            color: Colors.white,
          ),
          Text(
            " comprar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

Widget slideLeftBackground(){
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Icon(
            Icons.clear,
            color: Colors.white,
          ),
          Text(
            " Remover",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

class ProductDescription extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Descricao"),
          ),
          body:
          Center(
            child: Column(
                children: <Widget>[
                  ListTile(
                    leading: listaProduto[qq].image,
                    title: Text("\n"),
                  ),
                  ListTile(
                    title: Text("Nome: "+listaProduto[qq].nome+ "\nQuantidade: "+ listaProduto[qq].quantidade.toString()+ "\nPreco a Pagar:"+ listaProduto[qq].precoFinal().toString()+ "\nObservaçoes:"+ listaProduto[qq].observacoes),
                  ),
                ],
              ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            locked = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.edit),

        ),

      ),
    ) ;
  }

}




