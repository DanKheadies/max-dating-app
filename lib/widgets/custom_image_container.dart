import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:max_dating_app/blocs/blocs.dart';

class CustomImageContainer extends StatelessWidget {
  final String? imageUrl;
  // final TabController tabController;

  const CustomImageContainer({
    super.key,
    this.imageUrl,
    // required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: imageUrl == null
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () async {
                    var scon = ScaffoldMessenger.of(context);
                    var onCon = context.read<OnboardingBloc>();

                    ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image == null) {
                      scon.showSnackBar(
                        const SnackBar(
                          content: Text('No image was selected.'),
                        ),
                      );
                    } else {
                      print('uploading');
                      onCon.add(
                        UpdateUserImages(
                          image: image,
                        ),
                      );
                    }
                  },
                ),
              )
            : ClipRRect(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(50),
                // ),
                borderRadius: BorderRadius.circular(8),
                // TODO: show circle if not fully loaded
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
