package service.impl;

import entity.ExamResultQuestion;
import mapper.ExamResultQuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ExamResultQuestionService;

import java.util.List;

@Service
public class ExamResultQuestionServiceImpl implements ExamResultQuestionService {
    @Autowired
    private ExamResultQuestionMapper resultQuestionMapper;
    /*
    * 查询考试结果及正确答案
    * */
    @Override
    public List<ExamResultQuestion> getStudentAnswers(Integer examResultId) {
        return resultQuestionMapper.selectByResultId(examResultId);
    }
}
