import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_text.dart';

class AttendanceRequest extends StatelessWidget {

  final String text;
  final String date;
  final String subText;


  const AttendanceRequest({super.key, this.text="", this.date="", this.subText=""});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      padding: PaddingValue.small,
      borderRadius: 5,
      borderWidth: 0.6,
      width: double.infinity,
      color: const Color(0xff3f4b65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(text: text, color: CommonColor.white,),
              PopupMenuButton(
                color: CommonColor.white,
                iconColor: CommonColor.white,
                itemBuilder: (context){
                return const [
                  PopupMenuItem(
                    value: 'Last 7 days',
                    child: Text('Last 7 days'),
                  ),
                  PopupMenuItem(
                    value: 'Last 14 days',
                    child: Text('Last 14 days'),
                  ),
                  PopupMenuItem(
                    value: 'Last 30 days',
                    child: Text('Last 30 days'),
                  ),
                  PopupMenuItem(
                    value: 'Custom Range',
                    child: Text('Custom Range'),
                  ),
                ];
              })
            ],
          ),
          CommonText(text: date,color: CommonColor.white),
          Divider(thickness: 1,color: CommonColor.grey,),
          CommonContainer(
            width: double.infinity,
            padding: PaddingValue.small,
            borderColor: Colors.blue,
            child: CommonText(text: subText,color: Colors.blue),
          )
        ],
      ),
    );;
  }
}
