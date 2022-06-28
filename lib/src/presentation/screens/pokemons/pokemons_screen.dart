import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:bed/src/domain/constants/app_constant.dart';
import 'package:bed/src/domain/entities/pokemons/pokemon_entity.dart';
import 'package:bed/src/domain/usecases/pokemons/remote_pokemons_usecase.dart';

import 'package:bed/src/presentation/widgets/load_widget.dart';
import 'package:bed/src/presentation/widgets/image_widget.dart';
import 'package:bed/src/presentation/widgets/failure_widget.dart';
import 'package:bed/src/presentation/screens/pokemons/bloc/pokemons_bloc.dart';

class PokemonsScreen extends StatefulWidget {
  static const String pokemonsPath = 'home';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  int _offset = 0;

  late final PokemonsBloc _bloc = GetIt.instance.get<PokemonsBloc>();

  final PagingController<int, PokemonEntity> _scrollController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _scrollController.addPageRequestListener((offset) => _loadPokemons(offset));
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _loadPokemons(int offset) async {
    _bloc.add(
      GetPokemonsEvent(
        PokemonsParams(
          url: '${AppContants.urlPokeApi}?limit=10&offset=$offset',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<PokemonsBloc, PokemonsState>(
          bloc: _bloc,
          listener: (_, PokemonsState state) {
            if (state is PokemonsSuccess) {
              final pokemons = state.pokemons.results;
              final isLastPage = pokemons.length < _offset;

              if (isLastPage) {
                _scrollController.appendLastPage(pokemons);
              } else {
                _offset += 1;
                _scrollController.appendPage(pokemons, _offset);
              }
            }
          },
          child: BlocBuilder<PokemonsBloc, PokemonsState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is PokemonsLoading) {
                return loadWiget();
              }

              if (state is PokemonsFailure) {
                return failureMessageWidget(message: state.message);
              }

              return PagedGridView<int, PokemonEntity>(
                padding: const EdgeInsets.all(8.0),
                pagingController: _scrollController,
                showNoMoreItemsIndicatorAsGridChild: false,
                showNewPageErrorIndicatorAsGridChild: false,
                showNewPageProgressIndicatorAsGridChild: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                builderDelegate: PagedChildBuilderDelegate<PokemonEntity>(
                  itemBuilder: (_, item, index) {
                    return gridItem(index, item.name);
                  },
                  firstPageErrorIndicatorBuilder: (_) => ElevatedButton(
                    child: Text(_scrollController.error),
                    onPressed: () => _scrollController.refresh(),
                  ),
                  newPageErrorIndicatorBuilder: (_) => ElevatedButton(
                    child: Text(_scrollController.error),
                    onPressed: () => _scrollController.retryLastFailedRequest(),
                  ),
                  newPageProgressIndicatorBuilder: (_) => loadWiget(),
                  firstPageProgressIndicatorBuilder: (_) => loadWiget(),
                  noItemsFoundIndicatorBuilder: (_) => const Text('Not data'),
                  noMoreItemsIndicatorBuilder: (_) => const Text('Not data :('),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget gridItem(int index, String name) {
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
              child: loadImage(
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
