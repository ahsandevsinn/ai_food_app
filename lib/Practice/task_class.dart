enum Status { complete, incomplete }

class TaskParameters {
  String name;
  String description;
  Status status;
  TaskParameters(
      {required this.name, required this.description, required this.status});
}
