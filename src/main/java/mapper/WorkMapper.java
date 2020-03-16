package mapper;

import entity.Work;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WorkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Work record);

    int insertSelective(Work record);

    Work selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Work record);

    int updateByPrimaryKey(Work record);
    //根据作业名称查询
    Work selectByTitle(String title);
    //根据名称查询所有试题信息
    List<Work> selectAllBySelective(String title);
    //判断作业名称是否已经存在
    Work selectByTitleWithoutSelf(@Param("title") String title, @Param("id") Integer id);
    //根据学生ID查询当前需要参加的考试
    List<Map> selectByStudent(Integer studentId);
}