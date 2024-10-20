import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_Item.dart';
import '../settings/settings_screen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/states.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeLoaded) {
          return _HomeLoadedContent(state: state);
        } else if (state is HomeError) {
          return Scaffold(
            body: Center(child: Text('Error: ${state.message}')),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Unexpected state')),
        );
      },
    );
  }
}

class _HomeLoadedContent extends StatelessWidget {
  final HomeLoaded state;

  const _HomeLoadedContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double avatarRadius =
        isPortrait ? screenSize.width * 0.2 : screenSize.width * 0.12;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: isPortrait ? 28 : 30),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, SettingsScreen.routeName),
              child: Image.asset(
                'assets/icons/settings.png',
                width: screenSize.width * 0.08,
                height: screenSize.height * 0.08,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    _buildProfileImage(context, avatarRadius),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          _buildGridView(context, screenSize, isPortrait),
          SizedBox(height: isPortrait ? 10 : 5),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, double avatarRadius) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: MyTheme.primaryColor,
            radius: avatarRadius,
            backgroundImage: state.profileImage != null
                ? FileImage(state.profileImage!)
                : const AssetImage('assets/images/profile.png')
                    as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 15,
            child: GestureDetector(
              onTap: () => context.read<HomeCubit>().pickImage(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Colors.blueAccent,
                  ),
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: MyTheme.primaryColor,
                  child: const Icon(Icons.add, color: Colors.blue, size: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(
      BuildContext context, Size screenSize, bool isPortrait) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: isPortrait ? screenSize.height * 0.48 : screenSize.height * 0.4,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.itemsTag.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait ? 2 : 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _navigateToScreen(context, index),
              child: CustomItem(
                tagText: state.itemsTag[index],
                imagePath: state.itemsImages[index],
                style: Theme.of(context).textTheme.titleLarge,
                height: isPortrait ? 130 : 110,
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    Navigator.of(context).pushNamed(state.routes[index]);
  }
}