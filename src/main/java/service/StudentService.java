package service;


import entity.Student;

import java.util.List;
import java.util.Map;

public interface StudentService {
    //学生登录用
    public Student getStudentByUsernameAndPassword(String username, String password);
    //显示学生列表
    public List<Map> selectStudentListBySelective(String gradeName,String majorName,String realname);
    //删除学生
    public String deleteStudent(Integer sid);
    //添加学生
    public String insertStudent(Student student);
    //在编辑中显示学生信息
    public Student selectById(Integer id);
    //在编辑中更新学生新消息
    public String updateStudent(Student student);
}
