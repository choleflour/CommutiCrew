class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
@override
class _SearchScreenState extends State<SearchScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Container( width: double.infinity, // Full width
        height: double.infinity, // Full height
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 254, 182), // Background color
        ), child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Column (
            children: [ Container(margin: const EdgeInsets.only(top: 60.0), child: const Image(image: AssetImage('assets/images/allyintroduction.png'))),SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your destination',
                      labelStyle: TextStyle(color : Color(0xffd7263d)),
                    ),
                    keyboardType: TextInputType,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: ,
                    child: const Text('Search', style: TextStyle(fontSize: 20,  color: Color(0xff227619))),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
          ),
            ),
          ),
        ]),
      ),
    )));
  }
}