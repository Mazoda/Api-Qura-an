import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/widgets/SingleRecritator.dart';

class AllRecitations extends StatefulWidget {
  Chapter chapter;
  AllRecitations(this.chapter, {Key? key}) : super(key: key);

  @override
  State<AllRecitations> createState() => _AllRecitationsState();
}

class _AllRecitationsState extends State<AllRecitations> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
          appBar: AppBar(
           shadowColor: Colors.transparent.withOpacity(0),
            backgroundColor: Colors.black,
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       setState(() {
            //         provider.translated
            //             ? provider.translated = false
            //             : provider.translated = true;
            //       });
            //     },
            //     icon: Icon(Icons.language),
            //     color: Colors.white,
            //   ),
            // ],
          ),
          body: provider.recitations == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: provider.recitations!.length,
                          itemBuilder: ((context, index) {
                            return Singlerecritation(
                                provider.recitations![index], widget.chapter);
                          })),
                    ),
                  ],
                ));
    });
  }
}
