class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'UrbanSolve',
      image: './assets/detect.png',
      discription: "TURNING ROAD FRUSTRATION INTO ACTION"),
  UnbordingContent(
      title: 'Visualize Data',
      image: './assets/map.png',
      discription:
          "Visualize the data collected from the UrbanSolve app. "
          "This will help citizens and governments to make better decisions "
          "and improve the safety of the roads."),
];
