import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter_om_jeweller/widgets/inputs/custom_comment_text_form.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.onSearchBarPressed,
    this.onSubmit,
    this.readOnly = false,
    this.focusNode,
    this.hintText
  }) : super(key: key);

  final Function onSearchBarPressed;
  final Function onSubmit;
  final bool readOnly;
  final String hintText;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey[300],
              width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: CustomCommentTextFormField(
             isReadOnly: readOnly,
             focusNode: this.focusNode,
             hintText: hintText,
             textStyle: AppTextStyle.h4TitleTextStyle(),
             fillColor: AppColor.textFieldBackground(context),
             hintTextStyle: AppTextStyle.h4TitleTextStyle(
               color: AppColor.hintTextColor(context),
             ),
             prefixWidget:SvgPicture.asset(
               "assets/images/search_icon.svg",
                width: 18,
             ),

             /*Icon(
               FlutterIcons.search_mdi,
               color: Colors.grey[500],
             ),*/
             onTap: this.onSearchBarPressed,
             onFieldSubmitted: this.onSubmit,
           ),
    );
  }
}
