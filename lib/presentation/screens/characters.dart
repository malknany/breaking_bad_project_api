// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api/bloc_layer/cubit/characters_cubit.dart';
import 'package:flutter_api/constants/my_color.dart';
import 'package:flutter_api/data/model/chracter.dart';
import 'package:flutter_api/presentation/widget/character_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchForCharacters;
  bool _isSlected = false;
  TextEditingController searchTextController = TextEditingController();

  Widget _buildSearchFiled() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColor.myGray,
      decoration: const InputDecoration(
        hintText: 'Find a Characters',
        hintStyle: TextStyle(
          color: MyColor.myGray,
        ),
        border: InputBorder.none,
      ),
      onChanged: (searchCharacter) {
        searchedItemInList(searchCharacter);
      },
    );
  }

  void searchedItemInList(String searchCharacter) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppbarAction() {
    if (_isSlected) {
      return [
        IconButton(
          onPressed: () {
            _clearSaerching();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColor.myGray,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColor.myGray,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSaerching));
    setState(() {
      _isSlected = true;
    });
  }

  void _stopSaerching() {
    _clearSaerching();
    setState(() {
      _isSlected = false;
    });
  }

  void _clearSaerching() {
    setState(() {
      searchTextController.clear();
    });
  }

  Widget _buildAppbar() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColor.myGray,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColor.myYellow),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGray,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchForCharacters[index],
        );
      },
    );
  }

  Widget buildNoInterNetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              " Can't connect .. check internet",
              style: TextStyle(
                color: MyColor.myGray,
                fontSize: 22,
              ),
            ),
            Image.asset('assets/img/bug.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSlected
            ? const BackButton(
                color: MyColor.myGray,
              )
            : Container(),
        backgroundColor: MyColor.myYellow,
        title: _isSlected ? _buildSearchFiled() : _buildAppbar(),
        actions: _buildAppbarAction(),
        centerTitle: true,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInterNetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
