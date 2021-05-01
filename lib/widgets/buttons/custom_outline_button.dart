import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/widgets/state/busy_indicator.dart';

class CustomOutlineButton extends StatefulWidget {
  CustomOutlineButton({
    Key key,
    this.onPressed,
    this.onLongPress,
    this.elevation,
    this.child,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.borderColor,
    this.padding,
    this.shape,
    this.height,
    this.title,
    this.width,
    this.loading = false,
  }) : super(key: key);

  final Function onPressed;
  final Function onLongPress;
  final double elevation;
  final Widget child;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color borderColor;
  final EdgeInsets padding;
  final ShapeBorder shape;
  final bool loading;
  final double height;
  final double width;
  final String title;
  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return /* RaisedButton(
      elevation: widget.elevation ?? 0,
      padding: widget.padding ?? AppPaddings.buttonPadding(),
      color: widget.color ?? Colors.white,
      disabledColor: widget.disabledColor,
      disabledTextColor: widget.disabledTextColor,
      textColor: widget.textColor ?? Colors.black,
      shape: widget.shape ??
          */ /* StadiumBorder(
            side: BorderSide(color: widget.borderColor ?? Colors.transparent),
          ),*/ /*
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      child: widget.loading ? BusyIndicator() : widget.child,
    );*/
        InkWell(
          onTap: () => widget.onPressed,
      child: new Container(
        width: widget.width ?? 100,
        height: widget.height ?? 56.0,
        padding: widget.padding ?? EdgeInsets.all(16),
        decoration: new BoxDecoration(
          color: Colors.transparent,
          border: new Border.all(color: AppColor.accentColor, width: 1.0),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Center(
          child: new Text(
            widget.title ?? "",
            style: AppTextStyle.h4TitleTextStyle(color: AppColor.accentColor),
          ),
        ),
      ),
    );
  }
}
