package mapper;

import entity.Clazz;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ClazzMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Clazz record);

    int insertSelective(Clazz record);

    Clazz selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Clazz record);

    int updateByPrimaryKey(Clazz record);
    //显示班级列表
    List<Map> selectAllByGradeAndMajor(@Param("gradeName") String gradeName,@Param("majorName") String majorName);
    //查询班级是否存在
    Clazz selectOneExist(Clazz clazz);
    //根据年级和专业的id查询班级
    List<Clazz> selectAllGradeIdAndMajorId(@Param("gradeId") Integer gradeId,@Param("majorId") Integer majorId);
}