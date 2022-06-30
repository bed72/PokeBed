import 'package:bed/src/presentation/utils/debounce/call_debounce.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bed/src/domain/constants/app_constant.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/presentation/widgets/load_widget.dart';
import 'package:bed/src/presentation/widgets/image_widget.dart';
import 'package:bed/src/presentation/widgets/failure_widget.dart';
import 'package:bed/src/presentation/screens/pokemons/cubit/pokemons_cubit.dart';

class PokemonsScreen extends StatefulWidget {
  static const String pokemonsPath = 'home';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  int index = 0;

  String _url = '${AppContants.urlPokeApi}?limit=25&offset=0';

  late final ScrollController _scrollController;
  late final PokemonsBloc _bloc = GetIt.instance.get<PokemonsBloc>();

  @override
  void initState() {
    _loadPokemons();
    _setupScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollController() {
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  dynamic _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) _loadPokemons();
  }

  void _loadPokemons() {
    _bloc.loadPokemons(PokemonsParams(url: _url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PokemonsBloc, PokemonsState>(
          bloc: _bloc,
          buildWhen: (_, PokemonsState state) {
            if (state is PokemonsSuccess) {
              state.pokemons.next == null
                  ? _url = ''
                  : _url = state.pokemons.next!;

              return true;
            }
            if (state is PokemonsPagingLoading) {
              final snackBar = SnackBar(
                content: const Text('Loading...'),
                duration: const Duration(milliseconds: 800),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {},
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar).closed;
            }
            return false;
          },
          builder: (_, PokemonsState state) {
            if (state is PokemonsLoading) {
              return loadWiget();
            }

            if (state is PokemonsFailure) {
              return failureMessageWidget(message: state.message);
            }

            if (state is PokemonsSuccess) {
              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(4.0),
                itemCount: state.pokemons.results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.4,
                  crossAxisSpacing: 0.4,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return gridItemWidget(
                    index,
                    state.pokemons.results[index].name,
                  );
                },
              );
            }

            return loadWiget();
          },
        ),
      ),
    );
  }

  Widget notDataWidget() => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Not data'),
        ),
      );

  Widget gridItemWidget(int index, String name) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 96.0,
            height: 96.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: loadImageWidget(
                '${AppContants.urlPokeImages}${index + 1}.png',
              ),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text(name),
        ],
      ),
    );
  }
}
