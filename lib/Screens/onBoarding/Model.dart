class Unboardcontent{
  String image;
  String title;
  String description;

  Unboardcontent({required this.image,required this.title,required this.description});
}

List<Unboardcontent> contents=[
  Unboardcontent(
      title: 'Welcome',
      image: 'assets/firstAnimation.json',
      description: 'Cosmetics are pharmaceutical products that are used for '
          'improving skin appearance and body odor. These products are available '
          'in various forms, ranging from lotions, creams, powders, and so forth'
  ),
  Unboardcontent(
      title: 'Welcome',
      image: 'assets/SecondAnimation.json',
      description: 'Cosmetics are pharmaceutical products that are used for '
          'improving skin appearance and body odor. These products are available '
          'in various forms, ranging from lotions, creams, powders, and so forth'
  ),
  Unboardcontent(
      title: 'Welcome',
      image: 'assets/ThirdAnimation.json',
      description: 'Cosmetics are pharmaceutical products that are used for '
          'improving skin appearance and body odor. These products are available '
          'in various forms, ranging from lotions, creams, powders, and so forth'
  )
];