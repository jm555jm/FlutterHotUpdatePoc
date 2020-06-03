import 'package:dynamic_widget/dynamic_widget.dart';

class IncrementButtonListener implements ClickListener{
  IncrementButtonListener(this.onPress);

  Function onPress;
  @override
  void onClicked(String event) {
    onPress();
    print("Receive click event: " + event);
  }
}
