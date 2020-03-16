package mapper;

import entity.Exam;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ExamMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Exam record);

    int insertSelective(Exam record);

    Exam selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Exam record);

    int updateByPrimaryKey(Exam record);
    //根据试卷名称查询
    Exam selectByTitle(String title);
    //根据名称查询所有试题信息
    List<Exam> selectAllBySelective(String title);
    //判断试卷名称是否已经存在
    Exam selectByTitleWithoutSelf(@Param("title") String title,@Param("id") Integer id);
    //根据学生ID查询当前需要参加的考试
    List<Map> selectByStudent(Integer studentId);
}