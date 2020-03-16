package mapper;

import entity.ExamQuestions;

import java.util.List;
import java.util.Map;

public interface ExamQuestionsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamQuestions record);

    int insertSelective(ExamQuestions record);

    ExamQuestions selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamQuestions record);

    int updateByPrimaryKey(ExamQuestions record);
    //根据试卷ID查询试卷所有题目
    List<Map> selectAllByExamId(Integer fkExam);
    //判断试题是否已经添加
    ExamQuestions selectExist(ExamQuestions record);
}