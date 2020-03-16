package service;

import java.util.List;
import java.util.Map;

public interface ExamQuestionsService {
    public Integer saveQuestions(String ids,Integer eid,Integer qtype);

    public List<Map> getExamAllByExamId(Integer id);

    public String deleteExamQuestions(Integer id,Integer fkQuestion,Integer fkQtype,Integer fkExam);
}
