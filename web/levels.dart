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

}