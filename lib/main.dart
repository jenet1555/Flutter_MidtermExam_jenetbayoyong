import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Joshua Ursua', 'Basista, Pangasinan', 'June 7, 2001',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/313391435_3399343387009642_3861190886494409416_n.jpg?stp=cp6_dst-jpg&_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHhlzrGOijdMEiBKbGzqpqyRoiuULGcP05GiK5QsZw_Tqi9Cpv6uV6NEwxHFzRym3AvVX1Pz5aplDJZAhGS9__m&_nc_ohc=TV9rEIrY3XoAX_195Wy&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfDlh-4u_7aYrIkUN7-pzUIAzad33_23hOMNor9_m2RofQ&oe=64515F34'),
    Person('Jan Daryl Ursua', 'Basista, Pangasinan', 'April 11, 2006',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/315854917_908172133864775_3883608362959952582_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHv0v3anVck5ae6MS2MPcOS7euRlW9YsMPt65GVb1iww4Ep6e5_uQs4oYmByynedDTR0E3CgpKnZaTZxMqEZSTN&_nc_ohc=068gMyq1IboAX-Ch-Ms&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfBKC2qutd8qxw9UEI7uG4UJ5Gk3EReYU97fbDYjotwLDQ&oe=6450FEFE'),
    Person('Sample ', 'Basista, Pangasinan', 'June 6, 2003',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/243348098_605624047452920_2299741128913939948_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG85LuhgNEh7QDP5GLeS8bvRLhdonO4Cv5EuF2ic7gK_pQd8zvL0Nrfm69ENHTZs84LXNsBunYT69QMPsvLy7yp&_nc_ohc=UDBkcLmy9_kAX9TC3R3&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfBFMCjBkUKkx7ViT6aRIuinP_B1k8Y4qwLt6jaHcX7C-A&oe=6450E3BA'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ursua_Joshua_MidtermExam',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 5, 5),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 12, 12),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 22, 21, 21),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
