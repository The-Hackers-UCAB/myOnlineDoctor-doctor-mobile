// Flutter imports:
import 'package:flutter/material.dart';


//Project imports:
import '../styles/colors.dart';


///LoadingComponent: A progress indicator widget.
class LoadingComponent extends StatelessWidget {

  const LoadingComponent({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        value: null,
        strokeWidth: 4.0,
        color: colorPrimary,
      ),
    );
  }
}
