// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/constants/app_colors.dart';
import 'package:breaking_bad/data/model/character_model.dart';
import 'package:breaking_bad/logic/cubit/characters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final CharacterModel characterM;
  const DetailsScreen({Key? key, required this.characterM}) : super(key: key);

  Widget chackIfQuotesAreLoaded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmpatySpace(state);
    } else {
      return buildProgressWidgit();
    }
  }

  Widget displayRandomQuoteOrEmpatySpace(state) {
    var quote = (state).quotes;
    if (quote.length != 0) {
      int randomQuots = Random().nextInt(quote.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: AppColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: AppColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quote[randomQuots].quotes),
            ],
            isRepeatingAnimation: true,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildProgressWidgit() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllQuotes(characterM.name);
    return Scaffold(
      backgroundColor: AppColors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        "Job : ",
                        characterM.job.join(' , '),
                      ),
                      buildDivider(275),
                      characterInfo(
                        "Appeared in : ",
                        characterM.categoryForTwoSeries,
                      ),
                      buildDivider(210),
                      characterInfo(
                        "Seasons : ",
                        characterM.appearanceOfSeasons.join(' , '),
                      ),
                      buildDivider(235),
                      characterInfo(
                        "Status : ",
                        characterM.statusIfDeadOrAlive,
                      ),
                      buildDivider(255),
                      characterM.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              "Better Call Sual Seasons : ",
                              characterM.betterCallSaulAppearance.join(' , '),
                            ) ,
                      characterM.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(110),
                      characterInfo(
                        'Actor/Actress : ',
                        characterM.acotrName,
                      ),
                      buildDivider(195),
                      SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return chackIfQuotesAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          characterM.nickName,
          style: TextStyle(
            color: AppColors.myWhite,
          ),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: characterM.chartId,
          child: Image.network(
            characterM.images,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: AppColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              // decorationStyle: TextDecorationStyle.solid,
              // decoration: TextDecoration.underline,
              // decorationColor: AppColors.myYellow,
              // decorationThickness: 5.0,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: AppColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.myYellow,
      thickness: 2,
    );
  }
}
