import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_widget/common_padding.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/common_widget/common_value.dart';


class CommonContainerNLogo extends StatelessWidget {

  final IconData? icon;
  final String? text;
  final VoidCallback? onPressed;
  
  const CommonContainerNLogo({
    super.key, this.icon, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //background image and logo and signup txt

        Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppIcons.burgerImage),
                fit: BoxFit.cover,
              )
          ),

          //logo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [

                  CommonPadding(
                    edgeInsets: const EdgeInsetsDirectional.only(start: 25.0,bottom: 30.0),
                    child: IconButton(
                        icon:Icon(icon), color: Colors.white,
                        onPressed: onPressed,
                        ),
                  ),

                  CommonPadding(
                      edgeInsets: const EdgeInsetsDirectional.only(start: 77.0),
                      child: Image.asset('assets/images/png_images/symbols.png',fit: BoxFit.cover)),
                ],
              ),

              const Gap(Spacing.normal),

              //sign up text
              CommonText(text: text, color: Colors.white,fontSize: TextSize.largeHHeading, fontWeight: TextWeight.semiBold)
            ],
          ),
        ),

        Positioned(
            bottom: 0,
            left: -15,
            child: Image.asset('assets/images/png_images/frames.png')
        ),

      ],
    );
  }
}
