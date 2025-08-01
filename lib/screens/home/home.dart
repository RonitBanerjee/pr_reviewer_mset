import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_reviewer/constants/theme_colors.dart';
import 'package:pr_reviewer/screens/home/bloc/home_bloc.dart';
import 'package:pr_reviewer/widgets/cards/pr_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PR Reviewer',
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
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return CircularProgressIndicator();
          } else if (state is HomeLoadedState) {
            return Column(
              children: [
                SizedBox(height: 8),
                Column(
                  children:
                      state.pullrequests
                          .map((pr) => PrCard(prData: pr))
                          .toList(),
                ),
              ],
            );
          } else {
            return Container(child: Text('Error State!'));
          }
        },
      ),
    );
  }
}
