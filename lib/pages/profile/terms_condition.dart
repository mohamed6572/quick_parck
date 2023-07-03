import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: scaffoldBgColor,
        titleSpacing: 0.0,
        shadowColor: shadowColor.withOpacity(0.25),
        foregroundColor: lightBlackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          getTranslation(context, 'term_and_condition.terms_and_condition'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandae eenim quam aliquid molestiae non. Et enim quam. consequatur sunt dicta esse eveniet tempore deseruntpossimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaejhk at aliquimolestiae non. Et enim quam. Et consequatur sunt dicta esseveniet tempore deserunt.Possimus ipsa ea. Dolorum ea vel esit voluptatem quis ex. Sequi iusto velit rationerepudiandae ",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandae eenim quam aliquid molestiae non. Et enim quam. consequatur sunt dicta esse eveniet tempore deseruntpossimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaejhk at aliquimolestiae non. Et enim quam. Et consequatur sunt dicta esseveniet tempore deserunt.Possimus ipsa ea. Dolorum ea vel esit voluptatem quis ex. Sequi iusto velit rationerepudiandae ",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaealiquid molestiae non. Et enim quam. Et consequatur sunt dicta esse eveniet tempore deserunt.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandae eenim quam aliquid molestiae non. Et enim quam. consequatur sunt dicta esse eveniet tempore deseruntpossimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaejhk at aliquimolestiae non. Et enim quam. Et consequatur sunt dicta esseveniet tempore deserunt.Possimus ipsa ea. Dolorum ea vel esit voluptatem quis ex. Sequi iusto velit rationerepudiandae ",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandae eenim quam aliquid molestiae non. Et enim quam. consequatur sunt dicta esse eveniet tempore deseruntpossimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaejhk at aliquimolestiae non. Et enim quam. Et consequatur sunt dicta esseveniet tempore deserunt.Possimus ipsa ea. Dolorum ea vel esit voluptatem quis ex. Sequi iusto velit rationerepudiandae ",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaealiquid molestiae non. Et enim quam. Et consequatur sunt dicta esse eveniet tempore deserunt.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Possimus ipsa ea. Dolorum ea vel et sit voluptatem quis ex. Sequi iusto velit ratione voluptas repudiandaealiquid molestiae non. Et enim quam. Et consequatur sunt dicta esse eveniet tempore deserunt.",
            style: semibold14Grey,
          ),
        ],
      ),
    );
  }
}
