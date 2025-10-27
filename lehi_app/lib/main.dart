import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class EventStorage{
  static Map<DateTime, List<String>> eventsToLoad = {
    DateTime(2025, 10, 31): ["Halloween Parade", "Trick or Treat"],
    DateTime(2025, 11, 01): ["Day of the Dead Party"],
    DateTime(2025, 11, 18): ["Community Board Meeting"],
    DateTime(2025, 11, 27): ["Thanksgiving Parade"],
  };

  static List<String> _getEventsForDay(DateTime? day) {
    DateTime date;
    if(day != null){date = DateTime(day.year, day.month, day.day);}
    else{date = DateTime.now();}
    return eventsToLoad[date] ?? [];
  }

  static List<MapEntry<DateTime, String>> upcomingEvents({int count = 5}) {
    final now = DateTime.now();
    final eventsList = <MapEntry<DateTime, String>>[];

    eventsToLoad.forEach((date, events) {
      for (var e in events) {
        if (date.isAfter(now) || isSameDay(date, now)) {
          eventsList.add(MapEntry(date, e));
        }
      }
    });

    eventsList.sort((a, b) => a.key.compareTo(b.key));

    return eventsList.take(count).toList();}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: SizedBox(
      height: 40, 
      child: Image.asset(
      'images/logo.png',
      fit: BoxFit.contain, 
      ),
  ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OurVisionPage()),
                  );
                },
                child: const Text(
                  'Our Vision',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
             TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactUsPage()),
      );
    },
    child: const Text(
      'Contact Us',
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  ),
   TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResourcesPage()),
      );
    },
    child: const Text(
      'Resources',
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  ),
  TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutUsPage()),
      );
    },
    child: const Text(
      'About Us',
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  ),
  TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarPage()),
      );
    },
    child: const Text(
      'Calendar',
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  )
            ],
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body:SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      Image.asset(
        'images/mountains.jpeg',
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
      ),

      const SizedBox(height: 16),

      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Welcome to Lehi Cares!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Text("We’re a community change coalition that helps to prevent youth problems before they start. We’re a group that’s made up of people just like you. We either have kids, work with kids, or just care about kids and making our city a better place."),
      ),

      const SizedBox(height: 16),

      
      CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
        ),
        items: [
          'images/flyer.jpg',
          'images/visionimage.png',
          'images/image1.jpg'
        ].map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Image.asset(imageUrl, fit: BoxFit.contain),
              );
            },
          );
        }).toList(),
      ),

      const SizedBox(height: 20),

      Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Text(
    'Upcoming Events',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),


Column(
    children: [
      for (var e in EventStorage.upcomingEvents())
        _eventCard(
          e.value, 
          DateFormat("MMM d").format(e.key), 
        ),
    ],
  )

    ],
  ),
),

        ),
      ),
    );
  }

  Widget _eventCard(String title, String date) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          date,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    ),
  );
}


}

class OurVisionPage extends StatelessWidget {
  const OurVisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: const Text(
          'OUR VISION',
          style: TextStyle(color: Colors.black, fontFamily: 'Myriad-Pro', fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children:[ 
        const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'images/visionimage.png', 
                fit: BoxFit.cover,
                width: screenWidth * 0.9, 
              ),
            ),
            const Text(
          'Inspired by our rich heritage, Lehi Cares envisions a thriving, connected, inclusive community that is committed to continuously nurturing academic achievement, emotional health and multifaceted opportunities for all of our youth –  empowering the pioneering leaders of tomorrow, supporting families and maximizing public safety through proactive engagement.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        ]
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget{
  const AboutUsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'What is Lehi Cares?',
        'text': 'We’re a community change coalition that helps to prevent youth problems before they start. '
            'We’re a group that’s made up of people just like you. We either have kids, work with kids, or just care about kids and making our city a better place. '
            'Together with sponsorship from Lehi City government, we make up a community coalition that’s focused on decreasing the numbers of youth in Lehi who engage in things like delinquency, '
            'violence, alcohol and other drug use, school dropout, depression/anxiety, teen pregnancy and suicide.',
        'image': 'images/image1.jpg',
      },
      {
        'title': 'What Do We Do?',
        'text': 'We follow the University of Washington’s Communities That Care (CTC) framework to guide our process so we know we’re making the greatest impact possible. '
            'This includes doing a comprehensive assessment of Lehi, creating a 3–5 year action plan to implement programs and policies that will support our youth, '
            'and then tracking progress over time so we know that we’re making the changes that we set out to make.\n\n'
            'Some of our projects have included:\n'
            '• Qualitative research to discover the why behind our risk factors\n'
            '• Assessing resources available to support youth and families in Lehi\n'
            '• Supporting Take Back days to promote prescription drug safety\n'
            '• Partnering with the Dept of Alcoholic Beverage Services to execute media campaign to prevent underage drinking\n'
            '• Partnering with a state drug use prevention initiative to create a media campaign around underage drinking\n'
            '• Providing free workshops that teach parents how to increase the likelihood of healthy outcomes for their kids\n'
            '• Partnering with Lehi Serves to create a community clean up youth service project',
        'image': 'images/image2.jpg',
      },
      {
        'title': 'How Do We Do It?',
        'text': 'As a coalition we meet together monthly to work through the five phases of the CTC framework. '
            'We have smaller workgroups that meet together to work on specific tasks towards our larger goals as needed. '
            'We also educate the community on how to prevent health and behavior problems for our youth via community events, booths and workshops.',
        'image': 'images/image3.jpg',
      },
      {
        'title': 'Why Are We Doing This?',
        'text': 'Many serious problems that youth face today are PREVENTABLE. '
            'If we can stop youth from ever drinking alcohol, smoking cigarettes or using recreational drugs, '
            'we can reduce levels of delinquent behavior, youth crime and suicide. '
            'Community-based interventions like CTC coalitions are proven to reduce negative outcomes for youth, so Lehi City and those of us who volunteer on the coalition are joining forces to create a better future for our kids.\n\n'
            'By supporting this coalition, we expect these types of outcomes for Lehi’s youth:\n'
            '• Less drug use\n'
            '• Lower suicide rates\n'
            '• Less criminal activity\n'
            '• Improved mental health\n'
            '• Fewer teen pregnancies\n'
            '• Fewer sexually transmitted diseases\n'
            '• More students graduating on time\n'
            '• Better financial outcomes as adults',
        'image': 'images/image4.jpg',
      },
      {
        'title': 'How Can You Help?',
        'text': 'There are lots of ways to support our work! Contact us if you have questions: lehicares@lehi-ut.gov.\n\n'
            'Follow us on social media to stay up to date on our progress and share resources that we post.\n'
            'Learn how to support the youth in your life with our free resources for parents and anyone who works with youth. '
            'Also, learn more about the Utah Department of Health SHARP Survey.\n\n'
            'JOIN US! We could always use more caring people like you to help in the main work of the coalition. '
            'This is a unique volunteer opportunity to make real changes in Lehi that will last for years to come. '
            'You’ll make friends while providing a meaningful contribution to your community (while also getting free dinner once a month!) '
            'Fill out the form below to let us know your interest.',
        'image': null,
      },
      {
        'title': 'FAQs',
        'text': 'Do I need a specific background to participate?\n\n'
            'No! This isn’t just for people with a social services background. We have people with all sorts of backgrounds like education, health, tech, government, event planning and stay-at-home-super-moms. '
            'As a coalition we do marketing, data analysis, networking, social media, events, budgeting and more – tons of things that could leverage your unique skills and that don’t require any sort of experience with youth advocacy. '
            'The only requirement is that you have an interest in supporting Lehi’s youth.\n\n'
            'Do I have to live in Lehi?\n\n'
            'The majority of our members live in Lehi, but if you work in Lehi and would like to make it a better place for kids, please join us! We also have members from organizations that cover the Lehi area and want to be represented on the coalition, so if that’s you, let us know! '
            'If you live in a city with one of our sister coalitions, you may want to participate there instead American Fork, Pleasant Grove, Lindon, Vineyard, and Payson.\n\n'
            'Can young people participate?\n\n'
            'Yes! If you’re a teen or college student looking for a volunteer opportunity, we’d love to have you because your voice matters too! Do be aware that this is not a traditional service opportunity that provides a certain number of hours per week. '
            'Most of our workgroups meet once a month with assignments to work on in between, so we can’t guarantee a particular amount of service hours.\n\n'
            'Are you interested in being part of creating community-wide change for the betterment of our youth? Fill out the contact us form and we will contact you shortly.',
        'image': 'images/image5.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
       body: Builder(
        builder: (context) => Scaffold(
          
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(sections.length, (index) {
                  final section = sections[index];
                  final isEven = index % 2 == 0;

                  final hasImage = section['image'] != null && section['image']!.isNotEmpty;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: hasImage
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: isEven
                                ? [
                                    _buildImage(section['image']!),
                                    const SizedBox(width: 16),
                                    _buildTextSection(section['title']!, section['text']!),
                                  ]
                                : [
                                    _buildTextSection(section['title']!, section['text']!),
                                    const SizedBox(width: 16),
                                    _buildImage(section['image']!),
                                  ],
                          )
                        : 
                        _buildTextSection(section['title']!, section['text']!),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String path) {
    return Flexible(
      flex: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          path,
          height: (path == 'images/image2.jpg') ? 290 : 217,
          width: 289,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromRGBO(9, 12, 181, 1),
              fontFamily: 'baskerville',
              fontStyle: FontStyle.italic,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontFamily: 'MyriadPro')),
        ],
      ),
    );
  }
}


class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

 void _submitForm() {
  if (_formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDFF0D8),
            border: Border.all(color: const Color(0xFFD6E9C6), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your responses were successfully submitted.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Thank You!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );

    _formKey.currentState!.reset();
    _firstNameController.clear();
  _lastNameController.clear();
  _emailController.clear();
  _phoneController.clear();
  _experienceController.clear();
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'First name cannot be blank';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Last name cannot be blank';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email cannot be blank';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text('Phone', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone Number cannot be blank';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text('Do you have relevant experience or specific ways you would like to contribute? *',
                style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Experience cannot be blank';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Social Development Strategy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'MyriadPro',
              ),
            ),
            const SizedBox(height: 16),

            // SDS Section
            const Text(
              'The Social Development Strategy (SDS) is the science of bonding framed in a practical formula that any adult can apply.\n',
              style: TextStyle(fontSize: 16, fontFamily: 'MyriadPro'),
            ),
            const Text(
              'Bonding is more than just time spent together. It’s developed through three important processes—opportunities, skills and recognition. The resulting bonds then lead youth to be more likely to adopt the healthy beliefs you communicate to them and more receptive to clear standards that you communicate and model for them.\n',
              style: TextStyle(fontSize: 16, fontFamily: 'MyriadPro'),
            ),

            MouseRegion(
  cursor: SystemMouseCursors.click,
  child: GestureDetector(
    onTap: () => _launchURL('https://www.lehi-ut.gov/wp-content/uploads/2025/08/SDS-booklet.pdf.pdf'),
    child: const Text(
      'Want to learn and apply this formula? Click HERE for the Bonding Mini Guide.',
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'MyriadPro',
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    ),
  ),
),
           TextButton(
  style: TextButton.styleFrom(
    backgroundColor: Color(0xFF000080),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  onPressed: () {
    _launchURL('https://www.lehi-ut.gov/wp-content/uploads/2025/02/parent-consent-letter.pdf');
  },
  child: const Text.rich(
    TextSpan(
      children: [
        
        TextSpan(
          text: 'The SHARP Survey',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      
      ],
    ),
    style: TextStyle(color: Colors.white, fontSize: 16),
    textAlign: TextAlign.center,
  ),
),
const SizedBox(height: 24),

    
            const Text(
              'The SHARP Survey\n',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'MyriadPro',
              ),
            ),
            const Text(
              'The SHARP Survey is an anonymous and voluntary survey given to 6th through 12th grade students in spring 2025. It gathers valuable data on physical, social, and mental health; substance use; social connections; demographics; and risky or harmful behaviors—while also identifying the protective factors that help keep kids safe.\n',
              style: TextStyle(fontSize: 16, fontFamily: 'MyriadPro'),
            ),

            RichText(
  text: TextSpan(
    style: const TextStyle(
      fontSize: 16,
      fontFamily: 'MyriadPro',
      color: Colors.black,
    ),
    children: [
      const TextSpan(text: 'The SHARP Survey is an anonymous and voluntary survey given to 6th through 12th grade students in spring 2025. It gathers valuable data on physical, social, and mental health; substance use; social connections; demographics; and risky or harmful behaviors—while also identifying the protective factors that help keep kids safe.\n\n'),
      const TextSpan(
        text: 'SHARP is Confidential',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: ' – No responses can be linked to individual students or families, and results are only reported at a local level.\n'),
      const TextSpan(
        text: 'SHARP is Voluntary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: ' – Participation requires parental permission, and students can skip questions or stop the survey at any time.\n'),
      const TextSpan(
        text: 'SHARP is Safe',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: ' – Research shows that discussing topics like substance use and mental health is beneficial, not harmful.\n'),
      const TextSpan(
        text: 'SHARP is Accessible',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: ' – The survey takes 30-45 minutes to complete during school, and parents can review the questions at ',
      ),
      WidgetSpan(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _launchURL('https://www.sharp.utah.gov'),
            child: const Text(
              'www.sharp.utah.gov',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontFamily: 'MyriadPro',
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      const TextSpan(text: ' or in the school office.\n'),
      const TextSpan(
        text: 'SHARP is Valid Data',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: ' – The survey undergoes a peer-reviewed validation process to provide accurate and reliable data that helps guide prevention efforts in Lehi and support the well-being of our youth.\n\n'),
      const TextSpan(text: 'Administered by the Utah Department of Health and Human Services, the SHARP Survey plays a vital role in understanding and addressing the needs of our community.\n\n'),
    ],
  ),
),



            const Text(
              'Administered by the Utah Department of Health and Human Services, the SHARP Survey plays a vital role in understanding and addressing the needs of our community.\n',
              style: TextStyle(fontSize: 16, fontFamily: 'MyriadPro'),
            ),

            
            _buildLink(context, 'Free Parenting Resources Page', 'https://www.lehi-ut.gov/departments/police/lehi-cares-coalition/free-parenting-resources/'),
            _buildLink(context, 'Lehi Cares Facebook Page', 'https://www.facebook.com/LehiCares'),
            _buildLink(context, 'Information on Helping Children Cope After a Traumatic Event', 'https://childmind.org/guide/helping-children-cope-after-a-traumatic-event/'),
            _buildLink(context, 'Information on Talking to Children & Teens About Tragedy', 'https://healthcare.utah.edu/hmhi/resources/talking-to-children-about-tragedy'),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: MouseRegion(
      cursor: SystemMouseCursors.click, 
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'MyriadPro',
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),
  );
}

}

class CalendarPage extends StatelessWidget {
  
  const CalendarPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (newSelectedDay, newFocusedDay) {
                    setState(() {
                      selectedDay = newSelectedDay;
                      focusedDay = newFocusedDay;
                    });
                  },
                  onPageChanged: (newFocusedDay) {
                    setState(() {
                      focusedDay = newFocusedDay;
                      selectedDay = null;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 20),
                if (selectedDay != null)
                  Text(
                    DateFormat("MMMM d").format(selectedDay!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
            Expanded(
              child: EventStorage._getEventsForDay(selectedDay).isEmpty
                  ? const Center(
                      child: Text("No events for this day"),
                    )
                  : ListView.builder(
                      itemCount: EventStorage._getEventsForDay(selectedDay).length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.event),
                          title: Text(EventStorage._getEventsForDay(selectedDay)[index]),
                        );
                      },
                    ),
            ),
              ],
            );
          },
        ),
      ),
    );
  }
}



