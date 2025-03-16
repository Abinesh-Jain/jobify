class Job {
  final String? id;
  final String? title;
  final String? description;
  final String? company;
  final String? location;

  Job({this.id, this.title, this.description, this.company, this.location});

  factory Job.fromMap(data) {
    return Job(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      company: data['company'],
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'company': company,
      'location': location,
    };
  }
}
