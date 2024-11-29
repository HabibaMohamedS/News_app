import 'package:flutter/material.dart';
import 'package:news_app/api/api_services.dart';
import 'package:news_app/models/SourceModel.dart';
import 'package:news_app/sourcesList.dart';

class category_details extends StatefulWidget {
  const category_details({super.key, required this.viewID});
  final String viewID;

  @override
  State<category_details> createState() => _category_detailsState();
}

class _category_detailsState extends State<category_details> {
  int selectedSubID = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<SourceModel>(
            future: ApiServices.getSources(widget.viewID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error:${snapshot.error.toString()}"),
                );
              }
              SourceModel? sourceModel = snapshot.data as SourceModel?;
              List<Sources> sources = sourceModel?.sources ?? [];
              // if (selectedSubID == null && sources.isNotEmpty) {
              //   selectedSubID = sources[0].id as int;
              // }
              return SourcesList(
                  changeSelectedSource: (soureID) {}, sources: sources);
            }),
      ],
    );
  }
}
