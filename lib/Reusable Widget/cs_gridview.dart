import 'package:flutter/cupertino.dart';

class CSGridView extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;

  const CSGridView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding:padding ,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 230,
        childAspectRatio: 0.8,
        crossAxisSpacing: 15,
      ),
      itemBuilder: itemBuilder,
    );
  }
}