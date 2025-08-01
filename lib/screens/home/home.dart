import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pr_reviewer/constants/theme_colors.dart';
import 'package:pr_reviewer/helpers/utils/shared_prefs.dart';
import 'package:pr_reviewer/screens/home/bloc/home_bloc.dart';
import 'package:pr_reviewer/widgets/cards/pr_card.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? token;

  @override
  void initState() {
    super.initState();
    getToken();
    context.read<HomeBloc>().add(HomeInitialEvent());
  }

  Future<void> getToken() async {
    final t = await SharedPrefs.getToken();
    setState(() {
      token = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PR Wizard',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SharedPrefs.clearToken();
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await getToken();
              context.read<HomeBloc>().add(HomeInitialEvent());
            },
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    if (state is HomeLoadingState) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        },
      );
    } else if (state is HomeLoadedState) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔐  Your Token',
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    token ?? 'No Token Found',
                    style: const TextStyle(color: ThemeColors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...state.pullrequests.map((pr) => PrCard(prData: pr)).toList(),
        ],
      );
    } else {
      return const Center(child: Text('Error State!'));
    }
  }
}
