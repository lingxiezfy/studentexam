package mapper;

import entity.Teacher;
import entity.TeacherClazz;

import java.util.List;
import java.util.Map;

public interface TeacherClazzMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TeacherClazz record);

    int insertSelective(TeacherClazz record);

    TeacherClazz selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TeacherClazz record);

    int updateByPrimaryKey(TeacherClazz record);

    TeacherClazz selectByFKTeacherAndFKClazz(TeacherClazz teacherClazz);

    List<TeacherClazz> selectTeachClass(Integer teacherId);

    List<Map> selectByFKTeacher(Integer teacherId);

    /**
     * 获取班级的教师团队
     * @param clazzId 班级Id
     * @return 任教的教师团队
     */
    List<Teacher> selectTeacherByClazzId(Integer clazzId);
}