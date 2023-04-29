import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class PicturesScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const PicturesScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var images = state.user.imageUrls;
    var imagesCount = images.length;

    return OnboardingLayout(
      currentStep: 4,
      onPressed: () {
        context.read<OnboardingBloc>().add(
              ContinueOnboarding(
                user: state.user,
              ),
            );
      },
      children: [
        const CustomTextHeader(
          text: 'Add 2 or More Pictures',
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 400,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.66,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              // TODO: sizing is off slightly now when the pic uploads
              return imagesCount > index
                  ? UserImage.medium(
                      url: images[index],
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      width: 50,
                    )
                  : AddUserImage(
                      onPressed: () async {
                        var scaffContext = ScaffoldMessenger.of(context);
                        var blocOnboardContext =
                            BlocProvider.of<OnboardingBloc>(context);

                        final XFile? image = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );

                        if (image == null) {
                          scaffContext.showSnackBar(
                            const SnackBar(
                              content: Text('No image was selected.'),
                            ),
                          );
                        } else {
                          print('Uploading...');
                          print(image.path);
                          blocOnboardContext.add(
                            UpdateUserImages(
                              image: image,
                            ),
                          );
                        }
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
