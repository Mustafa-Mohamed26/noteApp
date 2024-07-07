import 'package:client/constant/linkapi.dart';
import 'package:client/model/notemodel.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final NoteModel noteModel;
  final void Function()? onDelete;
  const CardNotes(
      {super.key,
      required this.ontap,
      required this.onDelete,
      required this.noteModel});

  @override
  // This is the build method for the CardNotes widget. It is a widget that displays
  // a single note in a card format.
  //
  // The build method takes a BuildContext object as a parameter. This object
  // provides information about the location of the widget in the widget tree.
  //
  // The build method returns a Widget object. This object represents the UI
  // that will be displayed.
  //
  // The build method contains nested widgets that are used to create the card
  // view. The card view consists of an image, a title, content, and a delete button.
  //
  // The image is displayed using an Image.network widget. The image URL is created
  // using the linkImageRoute constant and the noteModel.notesImage property.
  //
  // The title and content are displayed using Text widgets. The text is created
  // using string interpolation to concatenate the noteModel.notesTitle and
  // noteModel.notesContent properties.
  //
  // The delete button is displayed using an IconButton widget. The delete button
  // is an icon with the Icons.delete icon. When the delete button is tapped, the
  // onDelete function is called.
  Widget build(BuildContext context) {
    // Return an InkWell widget that responds to tap gestures.
    //
    // The onTap property is set to the ontap function.
    //
    // The child property is set to a Card widget.
    return InkWell(
      onTap: ontap,
      child: Card(
        // The child property of the Card widget is set to a Row widget.
        child: Row(
          // The children property of the Row widget is a list of Expanded widgets.
          children: [
            // The first Expanded widget displays the image.
            Expanded(
              // The flex property sets the flex value for the widget.
              flex: 1,
              child: Image.network(
                // The image URL is created using the linkImageRoute constant and the noteModel.notesImage property.
                "$linkImageRoute/${noteModel.notesImage}",
                // The width and height properties set the size of the image.
                width: 100,
                height: 100,
                // The fit property sets how the image should be fit within the size.
                fit: BoxFit.fill,
              ),
            ),
            // The second Expanded widget displays the title, content, and delete button.
            Expanded(
              // The flex property sets the flex value for the widget.
              flex: 2,
              // The child property of the Expanded widget is a ListTile widget.
              child: ListTile(
                // The title property of the ListTile widget is set to a Text widget.
                // The text is created using string interpolation to concatenate the noteModel.notesTitle property.
                title: Text("${noteModel.notesTitle}"),
                // The subtitle property of the ListTile widget is set to a Text widget.
                // The text is created using string interpolation to concatenate the noteModel.notesContent property.
                subtitle: Text("${noteModel.notesContent}"),
                // The trailing property of the ListTile widget is set to an IconButton widget.
                trailing: IconButton(
                  // The icon property of the IconButton widget is set to an Icon widget with the Icons.delete icon.
                  icon: const Icon(Icons.delete),
                  // The onPressed property of the IconButton widget is set to the onDelete function.
                  onPressed: onDelete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
