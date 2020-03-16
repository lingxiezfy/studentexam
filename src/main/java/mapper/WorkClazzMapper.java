package mapper;

import entity.WorkClazz;

import java.util.List;
import java.util.Map;

public interface WorkClazzMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkClazz record);

    int insertSelective(WorkClazz record);

    WorkClazz selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkClazz record);

    int updateByPrimaryKey(WorkClazz record);

    //根据作业ID查询关联的班级列表
    List<Map> selectByFkWork(Integer fkWork);
    //根据作业ID和班级ID查询关联记录
    WorkClazz selectByFkWorkAndFkClazz(WorkClazz workClazz);
}