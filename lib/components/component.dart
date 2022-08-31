import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';

Widget BuildNoteItem(Map model, context) => Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    '${model['title']}',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Amiri',
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )),
      ),
    );
