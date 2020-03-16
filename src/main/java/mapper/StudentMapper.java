package mapper;

import entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StudentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    int insertSelective(Student record);

    Student selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);
    //用于登录，传递学生的用户名和密码
    Student selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    //显示学生列表
    List<Map> selectAllBySelective(@Param("gradeName") String gradeName,@Param("majorName")String majorName,@Param("realname")String realname);
    //根据用户名查询学生信息
    Student selectByUsername(String name);
    //更新学生信息
    Student selectByUsernameWithoutSelf(@Param("username") String name,@Param("id") Integer sid);
}