package mapper;

import entity.ExamClazz;

import java.util.List;
import java.util.Map;

public interface ExamClazzMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamClazz record);

    int insertSelective(ExamClazz record);

    ExamClazz selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamClazz record);

    int updateByPrimaryKey(ExamClazz record);
    //根据试卷ID查询关联的班级列表
    List<Map> selectByFkExam(Integer fkExam);
    //根据试卷ID和班级ID查询关联记录
    ExamClazz selectByFkExamAndFkClazz(ExamClazz examClazz);
}