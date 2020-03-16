package mapper;

import entity.ExamResultQuestion;

import java.util.List;

public interface ExamResultQuestionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamResultQuestion record);

    int insertSelective(ExamResultQuestion record);

    ExamResultQuestion selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamResultQuestion record);

    int updateByPrimaryKey(ExamResultQuestion record);

    List<ExamResultQuestion> selectByResultId(Integer examResultId);
}