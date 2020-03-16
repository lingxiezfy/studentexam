package service;

import entity.ExamResultQuestion;

import java.util.List;

public interface ExamResultQuestionService {
    public List<ExamResultQuestion> getStudentAnswers(Integer examResultId);
}
