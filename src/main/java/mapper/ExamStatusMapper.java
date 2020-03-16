package mapper;

import entity.ExamStatus;

public interface ExamStatusMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamStatus record);

    int insertSelective(ExamStatus record);

    ExamStatus selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamStatus record);

    int updateByPrimaryKey(ExamStatus record);
}