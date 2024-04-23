class Unboardcontent{
  String image;
  String title;
  String description;

  Unboardcontent({required this.image,required this.title,required this.description});
}

List<Unboardcontent> contents=[
  Unboardcontent(
      title: 'Welcome to Zwigzo',
      image: 'assets/firstAnimation.json',
      description: 'Our Trust Make Your Taste'
  ),
  Unboardcontent(
      title: 'Welcome to Zwigzo',
      image: 'assets/SecondAnimation.json',
      description: 'Fast Delivery'
  ),
  Unboardcontent(
      title: 'Welcome to Zwigzo',
      image: 'assets/ThirdAnimation.json',
      description: "Let's Go..."
  )
];