package mapper;

import entity.Major;

import java.util.List;

public interface MajorMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Major record);

    int insertSelective(Major record);

    Major selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Major record);

    int updateByPrimaryKey(Major record);
    //显示专业列表
    List<Major> selectAllBySelective(String name);
    //添加专业
    Major selectByName(String name);
}