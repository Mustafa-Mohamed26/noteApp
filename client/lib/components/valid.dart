// ignore_for_file: unnecessary_string_interpolations

import 'package:client/constant/message.dart';

/// Validates the input string and returns a message if it is invalid.
/// The [val] parameter is the input string to be validated.
/// The [min] parameter is the minimum length the string must have.
/// The [max] parameter is the maximum length the string can have.
///
/// Returns:
/// If the input string is empty, returns the [messageInputEmpty].
/// If the length of the input string is greater than [max], returns the [messageInputMax] with the value of [max] substituted.
/// If the length of the input string is less than [min], returns the [messageInputMin] with the value of [min] substituted.
///
/// For example:
/// validInput("Hello", 5, 10); // returns null
/// validInput("HelloWorld", 5, 10); // returns "Input must be less than 10"
/// validInput("", 5, 10); // returns "Input cannot be empty"
/// validInput("H", 5, 10); // returns "Input must be at least 5"
///
validInput(String val, int min, int max){
  // if the input string is empty
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
  // if the length of the input string is greater than [max]
  if(val.length > max){
    return "$messageInputMax $max";
  }
  // if the length of the input string is less than [min]
  if(val.length < min){
    return "$messageInputMin $min";
  }
  
}
