package mapper;

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

    List<Map> selectByFKTeacher(Integer teacherId);
}