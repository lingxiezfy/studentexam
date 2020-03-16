package service;

import entity.QuestionJudge;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface QuestionJudgeService {
    public String saveJudge(QuestionJudge judge, HttpSession session);

    public List<Map> getjudgeAllBySelective(String title, Integer qtype);

    public QuestionJudge getJudgeById(Integer id);

    public String updateJudge(QuestionJudge judge,HttpSession session);

    public String deleteJudge(Integer jid);

    List<QuestionJudge> getJudgeAllByExamId(Integer examId);
}
