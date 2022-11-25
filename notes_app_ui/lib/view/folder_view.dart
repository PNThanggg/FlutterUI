import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app_ui/app_color.dart';
import 'package:notes_app_ui/widget/curved_box.dart';

class FolderView extends StatelessWidget {
  const FolderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          FontAwesomeIcons.plus,
          color: AppColors.white,
        ),
      ),
      body: MasonryGridView.count(
          itemCount: 5,
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) => CurvedBox(
                child: [
                  Lottie.asset("assets/folder.json", repeat: false),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == 0
                          ? Text(
                              'To Do',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : index == 1
                              ? Text(
                                  'Freelancer',
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              : index == 2
                                  ? Text(
                                      'Daily Life',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  : index == 3
                                      ? Text(
                                          'My Targets',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        )
                                      : index == 4
                                          ? Text(
                                              'Quotes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            )
                                          : const SizedBox.shrink()
                    ],
                  )
                ],
              )),
    );
  }
}
