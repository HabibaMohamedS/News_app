import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/SourceModel.dart';
import 'package:news_app/newsList.dart';

class SourcesList extends StatefulWidget {
  const SourcesList(
      {super.key, required this.changeSelectedSource, required this.sources});
  final List<Sources> sources;
  final void Function(String) changeSelectedSource;
  @override
  State<SourcesList> createState() => _SourcesListState();
}

class _SourcesListState extends State<SourcesList> {
  String? selectedSubID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSubID = widget.sources.isNotEmpty ? widget.sources[0].id : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: ChoiceChip(
                onSelected: (value) {
                  selectedSubID = widget.sources[index].id;
                  setState(() {});
                },
                label: Text(widget.sources[index].name ?? ""),
                selected: widget.sources[index].id == selectedSubID,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r)),
                selectedColor: Colors.green,
              ),
            ),
            itemCount: widget.sources.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        if (selectedSubID != null) NewsList(sourceID: selectedSubID!)
      ],
    );
  }
}
