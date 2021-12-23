import 'package:breaking_bad/constants/app_colors.dart';
import 'package:breaking_bad/data/model/character_model.dart';
import 'package:breaking_bad/logic/cubit/characters_cubit.dart';

import 'package:breaking_bad/ui/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersHomePage extends StatefulWidget {
  const CharactersHomePage({Key? key}) : super(key: key);

  @override
  State<CharactersHomePage> createState() => _CharactersHomePageState();
}

class _CharactersHomePageState extends State<CharactersHomePage> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedForCharacter;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.myGray,
      decoration: InputDecoration(
        hintText: 'Find a charcter...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.myGray,
          fontSize: 18.0,
        ),
      ),
      style: TextStyle(
        color: AppColors.myGray,
        fontSize: 18.0,
      ),
      onChanged: (searchedCharacter) =>
          addSearchForItemToSearchList(searchedCharacter),
    );
  }

  void addSearchForItemToSearchList(String searchedCharacter) {
    searchedForCharacter = allCharacters
        .where((charcter) =>
            charcter.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearData();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: AppColors.myGray,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: AppColors.myGray,
          ),
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearData();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearData() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(
        color: AppColors.myGray,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? BackButton(
                color: AppColors.myGray,
              )
            : Container(),
        backgroundColor: AppColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).charactersMod;
          return buildLoadedListWidget();
        } else {
          return buildProgressWidgit();
        }
      },
    );
  }

  Widget buildProgressWidgit() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.myGray,
        child: Column(
          children: [
            buildCharatersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharatersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          characterM: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacter[index],
        );
      },
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacter.length,
    );
  }
}
