import 'package:ai_food/Practice/task_class.dart';
import 'package:flutter/foundation.dart';

class ListManagementProvider extends ChangeNotifier{
  final List<String> _namesList= [];

  String _usrName = "";

  String get usrName => _usrName;

  List<String> get namesList => _namesList;

  List<String> namesListManagement(String newName){
    _namesList.add(newName);
    notifyListeners();
    return namesList;
  }

  String searchName(String name){
    if(_namesList.contains(name)){
      _usrName = name;
      notifyListeners();
      return _usrName;
    }
    _usrName = "";
    notifyListeners();
    return "";
  }


  //tasks list function
  final List<TaskParameters> _taskParams = [];

  List<TaskParameters> get taskParams => _taskParams;

  List<TaskParameters> addTask(TaskParameters taskParameters){
    _taskParams.add(taskParameters);
    notifyListeners();
    return _taskParams;
  }

  List<TaskParameters> deleteTask(int index){
    _taskParams.removeAt(index);
    notifyListeners();
    return _taskParams;
  }

  String getStatusString(Status status) {
    return status == Status.complete ? "Complete" : "Incomplete";
  }

  void updateTaskStatus(TaskParameters task, Status newStatus) {
    final index = _taskParams.indexOf(task);
    if (index != -1) {
      _taskParams[index].status = newStatus;
      notifyListeners();
    }
  }

  void updateTaskNameAndDescription(TaskParameters task, String newName, String newDescription) {
    final index = _taskParams.indexOf(task);
    if (index != -1) {
      _taskParams[index].name = newName;
      _taskParams[index].description = newDescription;
      notifyListeners();
    }
  }

}

