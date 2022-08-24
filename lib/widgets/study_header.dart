import 'package:flutter/material.dart';

import '../client/generic_service.dart';
import '../client/api_client.dart';
import '../data/data.dart';
import '../data/intern_model.dart';
import '../data/upload_model.dart';

class PlaylistHeader extends StatelessWidget {
  final Playlist playlist;

  const PlaylistHeader({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String url = endpoints.internGetId();
    String id = '932c13da-6cec-44bf-89c6-960692d0d611';

    getValue() async {
      UploadDetails uploadDetails =
      await GenericService<UploadDetails>()
          .get(UploadDetails.fromJson, url, id);
      print(uploadDetails.title);

      InternDetails internDetails =
      await GenericService<InternDetails>()
          .get(InternDetails.fromJson, url, id);
      print(internDetails.department);
    }


    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              playlist.imageURL,
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEPARTMENT',
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(fontSize: 12.0),
                  ),
                  const SizedBox(height: 12.0),
                  Text('nafaa kuchange',
                      style: Theme.of(context).textTheme.headline2),
                  const SizedBox(height: 16.0),
                  Text(
                    playlist.description,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Created by ${playlist.creator} • ${playlist.songs.length} topics, ${playlist.duration}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        _PlaylistButtons(followers: playlist.followers),
      ],
    );
  }
}

class _PlaylistButtons extends StatelessWidget {
  final String followers;

  const _PlaylistButtons({
    Key? key,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 48.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            primary: Theme.of(context).iconTheme.color,
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontSize: 12.0, letterSpacing: 2.0),
          ),
          onPressed: () {},
          child: const Text('RESUME'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: const Icon(Icons.thumb_up_alt_outlined),
          iconSize: 30.0,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          iconSize: 30.0,
          onPressed: () {},
        ),
        const Spacer(),
        Text(
          'Interns \04',
          style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
