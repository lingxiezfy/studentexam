package mapper;

import entity.WorkCorrecting;

public interface WorkCorrectingMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkCorrecting record);

    int insertSelective(WorkCorrecting record);

    WorkCorrecting selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkCorrecting record);

    int updateByPrimaryKey(WorkCorrecting record);

    WorkCorrecting selectBySubmitId(Integer submitId);
}