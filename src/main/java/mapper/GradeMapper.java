package mapper;

import entity.Grade;

import java.util.List;

public interface GradeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Grade record);

    int insertSelective(Grade record);

    Grade selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Grade record);

    int updateByPrimaryKey(Grade record);
    //显示年级列表
    List<Grade> selectAllBySelective(String name);
    //添加年级
    Grade selectByName(String name);
}