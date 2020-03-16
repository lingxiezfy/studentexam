package service;

import entity.QuestionMulti;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface QuestionMultiService {
    public String saveMulti(QuestionMulti questionMulti, HttpSession session);

    public List<Map> getMultiAllBySelective(String title,Integer qtype);

    public QuestionMulti getMultiById(Integer mid);

    public String updateMulti(QuestionMulti questionMulti,HttpSession session);

    public String deleteMulti(Integer mid);

    List<QuestionMulti> getMultiAllByExamId(Integer examId);
}
