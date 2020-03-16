package mapper;

import entity.ExamResult;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ExamResultMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamResult record);

    int insertSelective(ExamResult record);

    ExamResult selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamResult record);

    int updateByPrimaryKey(ExamResult record);

    ExamResult selectByFkExamAndFkStudent(ExamResult examResult);

    List<Map> selectByFkExamTitle(@Param("title") String title,@Param("studentId") Integer studentId);
}