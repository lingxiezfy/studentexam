package mapper;

import entity.WorkSubmit;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WorkSubmitMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkSubmit record);

    int insertSelective(WorkSubmit record);

    WorkSubmit selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkSubmit record);

    int updateByPrimaryKey(WorkSubmit record);

    WorkSubmit selectByWorkIdAndStudentId(@Param("workId") Integer workId,@Param("studentId")  Integer studentId);

    List<Map> statisticsSubmit(@Param("workId") Integer workId,@Param("classId") Integer classId);
}