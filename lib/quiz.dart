import 'package:flutter/cupertino.dart';

class Quiz {
  int? qId;
  String? qname;

  Quiz({
    this.qId,
    this.qname,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "quiz_id": qId,
      "name": qname,
    };
    if (qId != null) map['quiz_id'] = qId;
    return map;
  }

  Quiz.fromMap(Map<String, dynamic> map) {
    qId = map['quiz_id'];
    qname = map['name'];
  }
}

//class QuizList extends StateNotifier<List<Quiz>> {
 // QuizList(List<Quiz> state) : super(state ?? []);
 // void addAll(List<Quiz> Quiz) {
   // state.addAll(Quiz);
 // }

  //void add(Quiz quiz) {
  //  state = [
      //...state,
     // quiz,
   // ];
  //}
//}
