package mapper;

import entity.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Teacher record);

    int insertSelective(Teacher record);

    Teacher selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Teacher record);

    int updateByPrimaryKey(Teacher record);
    //教师登录
    Teacher selectByUsernameAndPassword(@Param("username") String username,@Param("password") String password);
    //根据用户名查询教师信息
    Teacher selectByUsername(String username);
    //根据条件查询所有教师列表
    List<Teacher> selectAllSelective(String realname);
    //根据用户名查询教师信息
    Teacher selectByUsernameWithoutSelf(Teacher teacher);
}