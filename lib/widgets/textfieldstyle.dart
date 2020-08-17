import 'package:erobot_app/import/importall.dart';

class InputStyle extends StatelessWidget {
  final String labelText;
  final Function validator;
  final double weight;
  final dynamic keyboardType;
  final int maxLines;

  const InputStyle({
    Key key,
    @required this.labelText,
    @required this.validator,
    this.weight = 1,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * weight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0),
        ),
        validator: validator,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
