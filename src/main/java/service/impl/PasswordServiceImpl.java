package service.impl;

import entity.Manager;
import entity.Student;
import entity.Teacher;
import mapper.ManagerMapper;
import mapper.StudentMapper;
import mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.PasswordService;
import util.MD5Util;

import javax.servlet.http.HttpSession;

@Service
public class PasswordServiceImpl implements PasswordService {
    @Autowired
    private ManagerMapper managerMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private TeacherMapper teacherMapper;
    private final byte MODIFIED = 1; //已经修改密码的标识
    /*
    * 更新密码
    * */
    @Override
    public String updatePwd(String oldPwd, String newPwd, HttpSession session) {
        String result = "";
        //获取登录用户的信息
        Object user = session.getAttribute("user");
        Integer role = (Integer)session.getAttribute("role");
        if(role == 1){
            //登录用户：学生
            Student stu = (Student) user;
            if(stu.getPassword().equals(MD5Util.getMD5(oldPwd))){
                stu.setPassword(MD5Util.getMD5(newPwd)); //新密码
                stu.setModified(MODIFIED); //修改了密码的标识
                Integer count = studentMapper.updateByPrimaryKeySelective(stu);
                if(count == 1){
                    //更新成功
                    result = "ok";
                }else{
                    //更新失败
                    result = "error";
                }
            }else{
                result = "old_error";
            }
        }else if(role == 2){
            //登录用户：教师
            Teacher tea = (Teacher)user;
            if(tea.getPassword().equals(MD5Util.getMD5(oldPwd))){
                tea.setPassword(MD5Util.getMD5(newPwd)); //新密码
                tea.setModified(MODIFIED); //修改了密码的标识
                Integer count = teacherMapper.updateByPrimaryKeySelective(tea);
                if(count == 1){
                    //更新成功
                    result = "ok";
                }else{
                    //更新失败
                    result = "error";
                }
            }else{
                result = "old_error";
            }
        }else if(role == 3){
            //登录用户：管理员
            Manager man = (Manager)user;
            if(man.getPassword().equals(MD5Util.getMD5(oldPwd))){
                man.setPassword(MD5Util.getMD5(newPwd)); //新密码
                man.setModified(MODIFIED); //修改了密码的标识
                Integer count = managerMapper.updateByPrimaryKeySelective(man);
                if(count == 1){
                    //更新成功
                    result = "ok";
                }else{
                    //更新失败
                    result = "error";
                }
            }else{
                result = "old_error";
            }
        }
        return result;

    }
}
