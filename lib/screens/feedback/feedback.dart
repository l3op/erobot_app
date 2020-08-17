import 'dart:io';

import 'package:erobot_app/import/importall.dart';
import 'package:file_picker/file_picker.dart';

class FeedbackApp extends StatefulWidget {
  FeedbackApp({Key key}) : super(key: key);

  @override
  _FeedbackAppState createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  String _filepath = '0';
  final _formkey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Form(
        key: _formkey2,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              InputStyle(
                alignwithhint: true,
                labelText: 'Write down your feedback here...',
                validator: (val) {
                  return val.isEmpty ? 'Please write your feedback!' : null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 10,
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _filepath == '0' ? 'Attachment(Optional)' : _filepath,
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        iconSize: 20,
                        onPressed: () async {
                          var filepath = await FilePicker.getFilePath(
                            type: FileType.any,
                          );
                          _filepath = File(filepath).path.split('/').last;
                          if (filepath != null) {
                            setState(
                              () {
                                _filepath = _filepath.toString();
                              },
                            );
                          }
                          print(_filepath);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.blue_pacific),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    splashColor: Color.fromRGBO(255, 255, 255, .2),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formkey2.currentState.validate()) {
                        print(_formkey2.currentState.toString());
                        print('');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
