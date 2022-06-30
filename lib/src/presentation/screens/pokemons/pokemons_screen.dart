import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bed/src/presentation/extensions/widget_extension.dart';

import 'package:bed/src/domain/constants/app_constant.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/presentation/mixins/state_mixin.dart';
import 'package:bed/src/presentation/widgets/load_widget.dart';
import 'package:bed/src/presentation/widgets/snack_widget.dart';
import 'package:bed/src/presentation/widgets/image_widget.dart';
import 'package:bed/src/presentation/widgets/failure_widget.dart';
import 'package:bed/src/presentation/screens/pokemons/cubit/pokemons_cubit.dart';

class PokemonsScreen extends StatefulWidget {
  static const String pokemonsPath = 'home';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> with StateMixin {
  String _url = '${AppContants.urlPokeApi}?limit=25&offset=0';

  late final ScrollController _scrollController;
  late final PokemonsBloc _bloc = widget.locator.get<PokemonsBloc>();

  @override
  void createdWidget() {
    _loadPokemons();
    _setupScrollController();
  }

  @override
  void destroyWidget() {
    _bloc.close();
    _scrollController.dispose();
  }

  void _setupScrollController() {
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  dynamic _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 16 &&
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
              snackBarWidget(
                context: context,
                message: 'Loading...',
              );

              return false;
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
          const SizedBox(height: 16.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14.0,
              letterSpacing: 0.9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
