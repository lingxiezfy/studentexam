package web.manager;

import entity.Manager;
import entity.Student;
import entity.Teacher;
import lombok.Data;

import java.util.Objects;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/3/31 0:48 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Data
public class UserCommon {
    private int role; // 1,学生;2,教师;3,管理员;
    private int id;
    private String name = "";
    private int clazzId = 0;


    public static UserCommon init(Student student){
        if(student != null){
            UserCommon user = new UserCommon();
            user.setRole(1);
            user.setId(student.getId());
            user.setClazzId(student.getFkClazz() == null ? 0:student.getFkClazz());
            user.setName(student.getRealname() == null ? (student.getUsername()+"(未实名)") : student.getRealname());
            return user;
        }
        return null;
    }

    public static UserCommon init(Teacher teacher){
        if(teacher != null){
            UserCommon user = new UserCommon();
            user.setRole(2);
            user.setId(teacher.getId());
            user.setName(teacher.getRealname() == null ? (teacher.getUsername()+"(未实名)") : teacher.getRealname());
            return user;
        }
        return null;
    }

    public static UserCommon init(Manager manager){
        if(manager != null){
            UserCommon user = new UserCommon();
            user.setRole(3);
            user.setId(manager.getId());
            user.setClazzId(0);
            user.setName(manager.getUsername() == null ?"Admin(未授权)": manager.getUsername());
            return user;
        }
        return null;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserCommon that = (UserCommon) o;
        return role == that.role &&
                id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(role, id);
    }

    @Override
    public String toString() {
        return "UserCommon{" +
                "role=" + role +
                ", id=" + id +
                ", name='" + name + '\'' +
                ", clazzId=" + clazzId +
                '}';
    }
}
