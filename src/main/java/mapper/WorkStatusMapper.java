package mapper;

import entity.WorkStatus;

public interface WorkStatusMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkStatus record);

    int insertSelective(WorkStatus record);

    WorkStatus selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkStatus record);

    int updateByPrimaryKey(WorkStatus record);
}