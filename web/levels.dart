part of ld42;

class Levels {

  static final Level TUTORIAL1 = new Level(
    <Drive>[
      new Drive(
        'Hard Disk',
        50, 200,
        128,
        <File>[
          new File('kittens.jpg', FileType.IMAGE, 6.7),
        ],
        <String>[
        ]
      ),
      new Drive(
        'USB Drive 1',
        400, 80,
        8,
        <File>[
        ],
        <String>[
          'kittens.jpg',
        ]
      )
    ],
    new Tutorial(
      begin: 'Hi! I\'m Stapley, your office assistant.\nIt looks like you\'re trying to move this picture of cute kittens to a flash drive. You should probably use drag & drop to do that.',
      end: 'Great job! I knew you could do it.\nI bet now you\'d like to see the picture of the kittens. Unfortunately, we don\'t have time for that right now. Let\'s move some more files instead.')
  );

  static final Level TUTORIAL2 = new Level(
    <Drive>[
      new Drive(
        'Hard Disk',
        50, 200,
        128,
        <File>[
          new File('kittens.jpg', FileType.IMAGE, 6.7),
        ],
        <String>[
        ]
      ),
      new Drive(
        'USB Drive 2',
        400, 80,
        8,
        <File>[
          new File('harold.gif', FileType.IMAGE, 7.2),
        ],
        <String>[
          'kittens.jpg',
        ]
      )
    ],
    new Tutorial(
      begin: 'These kittens are so cute you want to put them on every USB drive you own. But oh no! On this one there\'s already a picture of your uncle Harold and there\'s no more space! What to do?',
      end: 'Good. Nobody liked that picture of Harold anyway. Let\'s move on.')
  );

  static final Level TUTORIAL3 = new Level(
    <Drive>[
      new Drive(
        'Hard Disk',
        50, 200,
        128,
        <File>[
          new File('videos.zip', FileType.ZIP, 121.4),
          new File('passwords.txt', FileType.TEXT, 2.1),
        ],
        <String>[
          'kittens.jpg',
        ]
      ),
      new Drive(
        'USB Drive 2',
        400, 80,
        8,
        <File>[
          new File('kittens.jpg', FileType.IMAGE, 5.2),
        ],
        <String>[
        ]
      )
    ],
    new Tutorial(
      begin: 'Your friend Mike sent you this huge collection of interesting videos. Watching these videos was nice, but now you want your kittens back on your computer.',
      end: 'Wow, you\'re so clever.')
  );

  static final Level TUTORIAL4 = new Level(
    <Drive>[
      new Drive(
        'Hard Disk',
        50, 200,
        128,
        <File>[
          new ZipFile.withName('videos.zip', <File>[
            new File('secret.mp4', FileType.TEXT, 121.4 / 0.3),
          ]),
          new File('kittens.jpg', FileType.IMAGE, 5.2),
        ],
        <String>[
          'harrypotter.txt',
          'minions.txt',
          'terminator.txt',
        ]
      ),
      new Drive(
        'Mike\'s USB Drive',
        400, 80,
        8,
        <File>[
          new File('harrypotter.txt', FileType.TEXT, 2.4),
          new File('minions.txt', FileType.TEXT, 1.8),
          new File('terminator.txt', FileType.TEXT, 1.5),
        ],
        <String>[
        ]
      )
    ],
    new Tutorial(
      begin: 'Mike found these fanfiction stories online and you can\'t wait to read them! You might need to compress the files before transferring them: Select them by right-clicking, then press [Z].',
      zip: 'To uncompress the archive, select it and press [Z] again.',
      end: 'Nice! Now you\'ll have enough content to continue procrastinating your actual work.')
  );

  static final Level BOMB = new Level(
    <Drive>[
      new Drive(
        'Hard Disk',
        50, 200,
        128,
        <File>[
          new File('kittens.jpg', FileType.IMAGE, 5.2),
        ],
        <String>[
          'boom0.zip',
        ]
      ),
      new Drive(
        'Mysterious',
        400, 80,
        48,
        <File>[
          new ZipFile.withName('unzip_me.zip', <File>[
            new File('boom0.zip', FileType.ZIP, 16),
            new File('boom1.zip', FileType.ZIP, 16),
            new File('boom2.zip', FileType.ZIP, 16),
            new File('boom3.zip', FileType.ZIP, 16),
            new File('boom4.zip', FileType.ZIP, 16),
            new File('boom5.zip', FileType.ZIP, 16),
            new File('boom6.zip', FileType.ZIP, 16),
            new File('boom7.zip', FileType.ZIP, 16),
          ]),
        ],
        <String>[
        ]
      )
    ],
    new Tutorial(
      begin: 'What\'s this? Did Mike send you some more of those videos?',
      end: 'Oh no! It\'s a zip bomb! Your computer is completely destroyed.\nEither this is the end of the game or the developer just ran out of ideas for levels. Probably the latter.\n\n    Thank you for playing! <3')
  );

}