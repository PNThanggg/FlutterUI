import 'package:flutter/material.dart';
import 'package:notes_app_ui/widget/note_widget.dart';

import '../app_color.dart';
import 'home_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            child: const NoteWidget(),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "Daily Notes",
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Text(
              "Take note, reminders, set targets, collect resources and secure privacy",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView()
                  )
                );
              },
              child: Text(
                "Get started",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              )
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
        ],
      ),
    );
  }
}
