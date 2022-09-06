import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/bloc_layer/cubit/characters_cubit.dart';
import 'package:flutter_api/constants/my_color.dart';
import 'package:flutter_api/data/model/chracter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetailesScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailesScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliversAppBar() {
    return SliverAppBar(
      backgroundColor: MyColor.myGray,
      pinned: true,
      expandedHeight: 600,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickname,
          style: const TextStyle(
            color: MyColor.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(character.img, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.clip,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColor.myWhite,
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
      color: MyColor.myYellow,
      thickness: 2,
      endIndent: endIndent,
    );
  }

  Widget checkIfQuotesAreLoded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomeQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomeQuoteOrEmptySpace(state) {
    var quotes = (state).quote;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColor.myWhite,
            shadows: [
               Shadow(
                blurRadius: 7,
                color: MyColor.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getCharactersQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColor.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliversAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.fromLTRB(17, 15, 14, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', character.occupation.join(' / ')),
                      buildDivider(315),
                      characterInfo('Appeard in  : ', character.category),
                      buildDivider(250),
                      characterInfo(
                          'seasons  : ', character.appearance.join(' / ')),
                      buildDivider(270),
                      characterInfo('Status  : ', character.status),
                      buildDivider(300),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Saul Seasons  : ',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo('Actor/Actress  : ', character.name),
                      buildDivider(220),
                      const SizedBox(height: 20),
                      BlocBuilder<CharactersCubit,CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
