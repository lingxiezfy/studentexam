package mapper;

import entity.Manager;
import org.apache.ibatis.annotations.Param;

public interface ManagerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);
    //登录用，传递管理员的用户名和密码
    Manager selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
}