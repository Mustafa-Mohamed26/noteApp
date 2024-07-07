// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class NoteModel {
  int? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  int? notesUsers;

  NoteModel(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUsers});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }

  // This method converts a NoteModel object into a Map<String, dynamic>.
  // The resulting Map has keys that match the column names in the database table.
  // The values are the corresponding properties of the NoteModel object.
  // The Map is then returned by the method.
  Map<String, dynamic> toJson() {
    // Create a new Map to hold the data.
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // Add each property of the NoteModel object to the Map with the corresponding column name as the key.
    data['notes_id'] = this.notesId; // Add the 'notes_id' property to the Map.
    data['notes_title'] = this.notesTitle; // Add the 'notes_title' property to the Map.
    data['notes_content'] = this.notesContent; // Add the 'notes_content' property to the Map.
    data['notes_image'] = this.notesImage; // Add the 'notes_image' property to the Map.
    data['notes_users'] = this.notesUsers; // Add the 'notes_users' property to the Map.

    // Return the completed Map.
    return data;
  }
}