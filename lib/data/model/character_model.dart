class CharacterModel {
  late int chartId; //char_id
  late String name; //name
  late String nickName; //nickname
  late String images; //img
  late List<dynamic> job; //occupation
  late String statusIfDeadOrAlive; //status
  late List<dynamic> appearanceOfSeasons; //appearance
  late String acotrName; //portrayed
  late String categoryForTwoSeries; //category
  late List<dynamic> betterCallSaulAppearance; //better_call_saul_appearance

  CharacterModel.fromJson(Map<String, dynamic> json) {
    chartId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    images = json['img'];
    job = json['occupation'];
    statusIfDeadOrAlive = json['status'];
    appearanceOfSeasons = json['appearance'];
    acotrName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
