import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/build_social_button.dart';
import '../constants/constants_color.dart';
import '../models/argument.dart';

class ScreenMovieDetail extends StatelessWidget {
  static String routeName = '/screen_movie_detail';
  final Argument argument;
  final String imagePath = 'https://image.tmdb.org/t/p/w500/';
  const ScreenMovieDetail({
    Key? key,
    required this.argument,
  }) : super(key: key);

  Future share(SocialMedia platform) async {
    final subject = 'Mail';
    final urlShare =
        Uri.encodeComponent('https://www.youtube.com/watch?v=wdTshQQCqug');
    final text;

    if (argument.movie!.title != null) {
      text = argument.movie!.title;
    } else {
      text = argument.tv!.name;
    }

    final urls = {
      SocialMedia.facebook:
          ('https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text'),
      SocialMedia.twitter:
          ('https://www.twitter.com/intent/tweet?url=$urlShare&text=$text'),
      SocialMedia.linkedin:
          ('https://www.linkedin.com/shareArticle?mini=true&url=$urlShare'),
      SocialMedia.email: ('mailto:?subject=$subject&body=$text\n\n$urlShare'),
      SocialMedia.whatsapp:
          ('https://api.whatsapp.com/send?text=$text$urlShare'),
    };
    final url = urls[platform];
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url));
    } else {
      // can't launch url, there is some error
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String path;
    if (argument.movie!.posterPath != null) {
      path = imagePath + argument.movie!.posterPath!;
    } else if (argument.tv!.posterPath != null) {
      path = imagePath + argument.tv!.posterPath!;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: (argument.movie!.title != null)
            ? Text(argument.movie!.title!)
            : Text(argument.tv!.name!),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: size.height / 1.5,
                child: Image.network(path),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildSocialButton(
                    icon: FontAwesomeIcons.facebookSquare,
                    onClicked: () => share(SocialMedia.facebook),
                    color: cColorFacebook,
                  ),
                  BuildSocialButton(
                    icon: FontAwesomeIcons.twitterSquare,
                    onClicked: () => share(SocialMedia.twitter),
                    color: cColorTwitter,
                  ),
                  BuildSocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    onClicked: () => share(SocialMedia.linkedin),
                    color: cColorLinkedln,
                  ),
                  BuildSocialButton(
                    icon: FontAwesomeIcons.envelope,
                    onClicked: () => share(SocialMedia.email),
                    color: cAccentColor,
                  ),
                  BuildSocialButton(
                    icon: FontAwesomeIcons.whatsappSquare,
                    onClicked: () => share(SocialMedia.whatsapp),
                    color: cPrimaryColor,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: (argument.movie!.title != null)
                    ? Text(
                        argument.movie!.overview!,
                        textAlign: TextAlign.justify,
                      )
                    : Text(
                        argument.tv!.overview!,
                        textAlign: TextAlign.justify,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
