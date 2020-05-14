import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InfoPhotoPicker extends StatefulWidget {
  InfoPhotoPicker({Key key, @required this.title, @required this.onFileChanged, this.initImage}) : super(key: key);
  final String title;
  final File initImage;
  final void Function(File image) onFileChanged;

  @override
  _InfoPhotoPickerState createState() => _InfoPhotoPickerState();
}

class _InfoPhotoPickerState extends State<InfoPhotoPicker> {
  File _image;
  final _aspectRatio = 5 / 3;

  @override
  void didUpdateWidget(InfoPhotoPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initImage != null) {
      _image = widget.initImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(widget.title),
        ),
        GestureDetector(
          onTap: _showPicker,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
            child: AspectRatio(
              aspectRatio: _aspectRatio,
              child: _image == null
                  ? Center(child: Icon(Icons.add_circle_outline, color: Colors.black12, size: 46))
                  : Image.file(_image),
            ),
          ),
        )
      ],
    );
  }

  Future<T> _showPicker<T>() {
    return showModalBottomSheet<T>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildItem(0, 'Take photo'),
              Divider(height: 1),
              _buildItem(1, 'Picker from gallery'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, String title) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          Navigator.pop(context);
          _image = await ImagePicker.pickImage(source: index == 0 ? ImageSource.camera : ImageSource.gallery);
          widget.onFileChanged(_image);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
