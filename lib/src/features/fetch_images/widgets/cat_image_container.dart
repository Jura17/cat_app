import 'package:cat_app/src/features/fetch_images/controller/cat_controller.dart';
import 'package:cat_app/src/features/fetch_images/widgets/error_container.dart';
import 'package:cat_app/src/features/fetch_images/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatImageContainer extends StatelessWidget {
  const CatImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Consumer<CatController>(
        builder: (context, catController, _) {
          if (catController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (catController.catImageUrl == null) {
            return ErrorContainer();
          }
          return ImageContainer(catController: catController);
        },
      ),
    );
  }
}
