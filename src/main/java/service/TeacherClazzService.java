package service;

import entity.TeacherClazz;

import java.util.List;
import java.util.Map;

public interface TeacherClazzService {

    public String saveTeacherClazzService(TeacherClazz tc);

    public List<Map> getTeacherClazzAllByTeacherId(Integer teacherId);

    public String deleteTeacherClazz(Integer tid);
}
