import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../res/constants.dart';
import '../res/gobalcolor.dart';
import '../res/textstyle.dart';
import '../service/provider/imageaddremoveprovider.dart';

class SelectPhotoProfile extends StatelessWidget {
  const SelectPhotoProfile({super.key, required this.imagePicker});
  final ImagePicker imagePicker;
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: mq.width * .22,
              height: mq.height * .005,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          SizedBox(height: mq.height * .02),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: textstyle.largeBoldText)),
          SizedBox(
            height: mq.height * .01,
          ),
          Row(
            children: [
              _showBottomModelItem(textstyle, "Camera", Icons.camera_alt, () {
                Navigator.pop(context);

                _captureImageSingle(
                    context: context,
                    imagePicker: imagePicker,
                    imageSource: ImageSource.camera);
              }),
              SizedBox(
                width: mq.width * .066,
              ),
              _showBottomModelItem(textstyle, "Gallery", Icons.photo_album, () {
                Navigator.pop(context);

                _captureImageSingle(
                    context: context,
                    imagePicker: imagePicker,
                    imageSource: ImageSource.gallery);
              }),
            ],
          )
        ],
      ),
    );
  }

  _captureImageSingle(
      {required BuildContext context,
      required ImagePicker imagePicker,
      required ImageSource imageSource}) async {
    ImageAddRemoveProvider addUpdateProdcutProvider =
        Provider.of<ImageAddRemoveProvider>(context, listen: false);
    XFile? image = await imagePicker.pickImage(source: imageSource);
    addUpdateProdcutProvider.setSingleImageXFile(singleImageXFile: image);
  }

  Padding _showBottomModelItem(
      Textstyle textStyle, String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * .012, vertical: mq.height * .012),
      child: InkWell(
        onTap: funcion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: greenColor)),
              child: Icon(
                icon,
                color: greenColor,
              ),
            ),
            SizedBox(
              height: mq.width * .01,
            ),
            Text(
              title,
              style: textStyle.mediumText600.copyWith(color: greenColor),
            ),
          ],
        ),
      ),
    );
  }
}
