// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:breaking_bad/constants/app_colors.dart';
import 'package:breaking_bad/constants/const_strings.dart';
import 'package:breaking_bad/data/model/character_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel characterM;
  const CharacterItem({Key? key, required this.characterM}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          detailsRouter,
          arguments: characterM,
        ),
        child: GridTile(
          child: Hero(
            tag: characterM.chartId,
            child: Container(
              color: AppColors.myGray,
              child: characterM.images.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: 10.0,
                      height: 10.0,
                      placeholder: 'assets/image/loading.gif',
                      image: characterM.images,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/image/placeholder.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${characterM.name}",
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.myWhite,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
