import 'package:flutter/material.dart';
import 'package:intern_study_guide/data/content_creator_model.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../client/api_client.dart';
import '../client/stream_service.dart';
import '../data/intern_model.dart';
import '../data/upload_model.dart';

class MultipleStream extends StatefulWidget {
  const MultipleStream({Key? key}) : super(key: key);

  @override
  State<MultipleStream> createState() => _MultipleStreamState();
}

class _MultipleStreamState extends State<MultipleStream> {
  var stream1 = StreamService<InternDetails>().streamData(
      InternDetails.fromJson,
      endpoints.internGetId(),
      '148eaa64-71ca-477a-8e74-299473dccde0');
  var stream2 = StreamService<UploadDetails>().streamData(
      UploadDetails.fromJson,
      endpoints.uploadGetId(),
      '859ed698-9b4f-4dd1-bdf6-dac690fd32eb');
  var stream3 = StreamService<ContentCreatorDetails>().streamData(
      ContentCreatorDetails.fromJson,
      endpoints.contentCreatorGetId(),
      'f7d0365b-3822-44db-b05f-f3467283a46c');

// Pass multiple streams into a single StreamBuilder
  Widget build(BuildContext context) {
    return StreamBuilder3<InternDetails, UploadDetails, ContentCreatorDetails>(
      streams: StreamTuple3(stream1, stream2, stream3),
      initialData: InitialDataTuple3(
          InternDetails(
            pfNumber: 'loading',
            workEmail: 'loading',
            department: 'loading',
          ),
          UploadDetails(
              title: 'loading',
              department: 'loading',
              content: ['loading'],
              summary: 'loading',
              duration: 0),
          ContentCreatorDetails(
              workEmail: 'loading', department: 'loading', role: 'loading')),
      builder: (context, snapshots) {
        return Text(
          'stream1: ${snapshots.snapshot1.data!.department.toString()} - stream2: ${snapshots.snapshot2.data!.title} - stream3: ${snapshots.snapshot3.data!.role}',
        );
      },
    );
  }
}
