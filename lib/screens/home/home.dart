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
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    getToken();
    context.read<HomeBloc>().add(HomeInitialEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
      backgroundColor: isDarkMode ? ThemeColors.black : null,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(Icons.auto_fix_high, color: Colors.blue),
        ),
        title: Text(
          'PR Wizard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: Icon(
              Icons.logout,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () async {
              await SharedPrefs.clearToken();
              GoRouter.of(context).go('/login');
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
          const SizedBox(height: 8),
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
          const SizedBox(height: 8),
          ...state.pullrequests.map((pr) => PrCard(prData: pr)).toList(),
        ],
      );
    } else {
      return const Center(child: Text('Error State!'));
    }
  }
}
