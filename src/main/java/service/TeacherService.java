package service;

import entity.Teacher;

import java.util.List;

public interface TeacherService {
    //教师登录
    public Teacher getTeacherByUsernameAndPassword(String username,String password);

    public String saveTeacher(Teacher teacher);

    public List<Teacher> getTeacherAllBySelective(String realname);

    public String deleteTeacher(Integer tid);

    public Teacher getTeacherById(Integer id);

    public String updateTeacher(Teacher teacher);
}
