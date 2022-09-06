import 'package:flutter/material.dart';
import 'package:flutter_api/constants/my_color.dart';
import 'package:flutter_api/constants/string.dart';
import 'package:flutter_api/data/model/chracter.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailesScreen,arguments: character),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(character.name,style: const TextStyle(
              height: 1.3,
              fontSize: 16,color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColor.myGray,
              child: character.img.isNotEmpty ? FadeInImage.assetNetwork(
                placeholder: 'assets/img/loading.gif',
                image: character.img,
                fit: BoxFit.cover,) :Image.asset('assets/img/placeholder.jpg'),

            ),
          ),
        ),
      ),
    );
  }
}
