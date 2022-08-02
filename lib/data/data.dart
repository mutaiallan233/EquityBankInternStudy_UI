const yourLibrary = [
  'Made For You',
  'Recently Viewed',
  'Liked Content',
  'Library',
  'Authors',
];

const playlists = [
  'Today\'s Content',
  'Calender',
  'Tools',
];

class Study {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String duration;

  const Study({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
  });
}

const _studyContent = [
  Study(
    id: '0',
    title: 'CRUD Operations',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '1',
    title: 'Entity Framework',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '2',
    title: 'Clean Architecture',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '3',
    title: 'Authentication & Authorization',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '4',
    title: 'OAuth',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '5',
    title: 'Dependency Injection',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '6',
    title: 'Setup VS',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '7',
    title: 'HTTP requests',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '8',
    title: 'Interfaces',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '9',
    title: 'Models & Entity',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',  ),
  Study(
    id: '10',
    title: 'Controllers',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',
  ),
  Study(
    id: '11',
    title: 'PostMan',
    artist: 'Emmanuel Koech',
    album: '{Summary}',
    duration: '2 days',
  ),
];

class Playlist {
  final String id;
  final String name;
  final String imageURL;
  final String description;
  final String creator;
  final String duration;
  final String followers;
  final List<Study> songs;

  const Playlist({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.creator,
    required this.duration,
    required this.followers,
    required this.songs,
  });
}

const lofihiphopPlaylist = Playlist(
  id: '5-playlist',
  name: 'Solution Development - Integration Department',
  imageURL: 'assets/interns.png',
  description:
  '{Description of ToDo} - {objective of the study}',
  creator: '{Content Uploader}',
  duration: 'Period {In days}',
  followers: '5,351,685',
  songs: _studyContent,
);
