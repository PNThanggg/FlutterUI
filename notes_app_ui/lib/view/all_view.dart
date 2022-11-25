import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app_ui/app_color.dart';
import 'package:notes_app_ui/widget/curved_box.dart';
import 'package:notes_app_ui/widget/list_title_row.dart';

class AllView extends StatelessWidget {
  const AllView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          FontAwesomeIcons.notesMedical,
          color: AppColors.white,
        ),
      ),
      body: AnimationLimiter(
        child: MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: 6,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                        child: index == 0
                            ? CurvedBox(
                                child: [
                                  Text(
                                    'Reminder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const ListTitleRow(
                                    text: "Exploration Design",
                                    isChecked: true,
                                  ),
                                  const ListTitleRow(
                                    text: "Kuliah",
                                    isChecked: true,
                                  ),
                                  const ListTitleRow(
                                    text: "Learn 3D Model",
                                    isChecked: false,
                                  ),
                                  const ListTitleRow(
                                    text: "Design Shots",
                                    isChecked: false,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const DateFooter(
                                      date: "Jan 17", footerText: "To do")
                                ],
                              )
                            : index == 1
                                ? CurvedBox(
                                    child: [
                                      Text(
                                        "Quote today",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        '''"The best preparation for tomorrow is doing your best today"\n- PNT''',
                                      ),
                                      const DateFooter(
                                          date: "Jan 17", footerText: "To do")
                                    ],
                                  )
                                : index == 2
                                    ? CurvedBox(
                                        child: [
                                          Text(
                                            '2021 Hope',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Text(
                                              'I have a dream that must come true !!'),
                                          const ListTitleRow(
                                              isChecked: true,
                                              text: 'GPA above 3.60'),
                                          const ListTitleRow(
                                              isChecked: true,
                                              text: 'Have an ipad'),
                                          const ListTitleRow(
                                              isChecked: false,
                                              text: 'Holidays in Japan'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const DateFooter(
                                              date: 'Jan 21',
                                              footerText: 'My Targets')
                                        ],
                                      )
                                    : index == 3
                                        ? CurvedBox(
                                            padding: EdgeInsets.zero,
                                            child: [
                                              Container(
                                                  height: 150,
                                                  width: w,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Image.asset(
                                                    'assets/travel.jpg',
                                                    fit: BoxFit.cover,
                                                  )),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      CupertinoIcons.location,
                                                      color:
                                                          AppColors.lightGrey,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Kuta Beach',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .lightGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: Text(
                                                  'I stayed here for a big family vacation. This is a great affordable hotel to stay in Bali ...',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.lightGrey),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: DateFooter(
                                                    date: 'Dec 24',
                                                    footerText: 'Daily Life'),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )
                                        : index == 4
                                            ? CurvedBox(
                                                child: [
                                                  Text(
                                                    'Statistika',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text(
                                                      'Data science is the domain of study that deals with vast volumes of data using modern tools and techniques to find unseen patterns, derive meaningful information, and make business decisions.'),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  const DateFooter(
                                                      date: 'Jan 21',
                                                      footerText: 'My Targets')
                                                ],
                                              )
                                            : index == 5
                                                ? CurvedBox(
                                                    child: [
                                                      Text(
                                                        'My Diary >,<',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            CupertinoIcons
                                                                .lock_fill,
                                                            size: 55,
                                                            color: AppColors
                                                                .lightGrey,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      const DateFooter(
                                                          date: 'Jan 21',
                                                          footerText:
                                                              'My Targets')
                                                    ],
                                                  )
                                                : const SizedBox.shrink()),
                  ));
            }),
      ),
    );
  }
}

class DateFooter extends StatelessWidget {
  final String date, footerText;
  final TextStyle style = const TextStyle(color: AppColors.lightGrey);

  const DateFooter({Key? key, required this.date, required this.footerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: style,
        ),
        Text(
          footerText,
          style: style,
        )
      ],
    );
  }
}
