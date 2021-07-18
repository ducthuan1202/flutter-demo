// Generic function
import 'package:flutter/material.dart';

T getFirst<T>(List<T> arr){
  return arr.first;
}

// arrow function
T first<T>(List<T> arr) => arr.first;

// class with generic
class Collect<T>{
  List<T> data = <T>[];


  Collect(){
    print('ok ${T.runtimeType}');
  }

  add(T item){
    data.add(item);
  }

  show(){
    print(data);
  }

}


void test(){

  List<String> a = ['a', 'b'];
  final an = a.map((e) => Chip(label: Text(e)));

  final c = Collect<String>();
  c.add('nguyen');
  c.add('duc');
  c.add('thuan');
  c.show();

  final d = Collect<double>();
  d.add(1.0);
  d.add(3.2);
  d.add(4.8);
  d.show();
}