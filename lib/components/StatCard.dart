import 'package:flutter/material.dart';

import '../constants.dart';

class StatCard extends StatelessWidget {
  final String title,unit;
  final String value;
  final Color? color;
  const StatCard({Key? key,required this.value,required this.title,required this.unit,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
                                  color:color?? primaryColor,
                                  margin: const EdgeInsets.all(8),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(title,  style: const TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),),
                                      const  Divider(
                                          color: Colors.white,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(value ,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                                ),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,),
                                              ),
                                            ),
                                            Text(unit,style: const TextStyle(
                                                                           color: Colors.white,
                                                                           fontWeight: FontWeight.bold,
                                                                         ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
  }
}
