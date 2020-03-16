package service;

import entity.QuestionSingle;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface QuestionSingleService {
    public String saveSingle(QuestionSingle single, HttpSession session);

    public List<Map> getSingleAllBySelective(String title,Integer qtype);

    public QuestionSingle getSingleById(Integer id);

    public String updateSingle(QuestionSingle single,HttpSession session);

    public String deleteSingle(Integer sid);

    List<QuestionSingle> getSingleAllByExamId(Integer examId);
}
