package service;

import dto.GeneratePaperOption;
import entity.Exam;
import entity.ExamAnswer;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ExamService {
    public String saveExam(Exam exam, GeneratePaperOption generateOption, HttpSession session);

    public List<Exam> getExamAllBySelective(String title);

    public Exam getExamId(Integer eid);

    public String updateExam(Exam exam,HttpSession session);

    public String deleteExam(Integer id);

    public List<Map> getExamsByStudent(Integer studentId);

    public String updateStatus(Integer eid, Date endTime,Integer status);

    public String updateExamPoints(Integer fkQuestions,Integer qtype,Integer examId,Double oldPoints);

    public Map<String,Object> marking(ExamAnswer answerVO,Integer studentId);
}
