import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../search/models/artwork_model.dart';
import '../cubit/description_cubit.dart';

class DescriptionScreen extends StatefulWidget {
  final Artwork artwork;

  const DescriptionScreen({super.key, required this.artwork});

  @override
  DescriptionScreenState createState() => DescriptionScreenState();
}

class DescriptionScreenState extends State<DescriptionScreen> {
  @override
  void initState() {
    context.read<DescriptionCubit>().fetchDescriptionResult(widget.artwork.primaryImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Museum Screen'),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(child: BlocBuilder<DescriptionCubit, DescriptionState>(
        builder: (context, state) {
          if (state is DescriptionLoading) {
            return const CircularProgressIndicator();
          } else if (state is DescriptionLoaded) {
            final description = state.description;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(widget.artwork.primaryImage),
                    const SizedBox(height: 20),
                    Text(description.message),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          } else if (state is DescriptionError) {
            return Text('Error: ${state.message}');
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.artwork.title),
                Text(widget.artwork.primaryImage),
              ],
            );
          }
        },
      )),
    );
  }
}
