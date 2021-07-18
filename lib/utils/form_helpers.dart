import 'package:flutter/material.dart';

/// hàm build data source cho select options
/// với 1 option mặc định là null đầu tiên
List<DropdownMenuItem<String>> buildDropdownItems({
    required List<Map<String, String>> drawData,
    String? label = 'Click để chọn'
}) {

  final data = [
    {'id': '', 'name': label},
    ...drawData,
  ];

  return data.map((item) => DropdownMenuItem<String>(
    value: item['id'] ?? '',
    child: Text(item['name'] ?? ''),
  )).toList();

}

/// map dữ liệu từ graphql response sang dạng Map<String, String>
/// để dùng làm data source cho select options
List<Map<String, String>> mapCountries(Map<String, dynamic>? source){

  if(source==null || source.isEmpty){
    return [];
  }

  final data = source['countries']['items'];
  if(data.isEmpty){
    return [];
  }

  List<Map<String, String>> res = [];
  data.forEach((item) {
    res.add({
      'id': item['id'].toString(),
      'name': item['name'].toString(),
    });
  });

  return res;
}