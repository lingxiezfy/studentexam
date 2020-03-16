package service.impl;

import entity.Teacher;
import mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.TeacherService;
import util.MD5Util;

import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;
    private final byte DEL = 1;  //删除的标识
    private final byte ADD = 0;  //未删除
    private final byte MODIFIED = 0; //为修改密码
    private final String DEFAULT_PASSWORD = "111111";   //默认密码
    /*
    * 教师登录，根据用户名和姓名查询教师信息 9.10
    * */
    public Teacher getTeacherByUsernameAndPassword(String username, String password) {
        return teacherMapper.selectByUsernameAndPassword(username,password);
    }
    /*
    * 添加教师
    * */
    @Override
    public String saveTeacher(Teacher teacher) {
        String result = "error";
        //判断该教师是否存在
        Teacher hasTea = teacherMapper.selectByUsername(teacher.getUsername());
        if(hasTea != null){
            if(hasTea.getDelFlag() == DEL){
               //已存在但已删除
                teacher.setId(hasTea.getId());
                teacher.setDelFlag(ADD);
                teacher.setModified(MODIFIED);
                teacher.setPassword(MD5Util.getMD5(DEFAULT_PASSWORD));
                Integer rows = teacherMapper.updateByPrimaryKey(teacher);
                if(rows == 1){
                    result = "ok";
                }
            }else {
                //已存在未删除
                result = "exist";
            }
        }else {
            //添加数据
            teacher.setDelFlag(ADD);
            teacher.setModified(MODIFIED);
            teacher.setPassword(MD5Util.getMD5(DEFAULT_PASSWORD));
            Integer rows = teacherMapper.insertSelective(teacher);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    //查询教师列表
    @Override
    public List<Teacher> getTeacherAllBySelective(String realname) {
        return teacherMapper.selectAllSelective(realname);
    }
    //删除教师
    @Override
    public String deleteTeacher(Integer tid) {
        Teacher teacher = new Teacher();
        teacher.setId(tid);
        teacher.setDelFlag(DEL);
        Integer rows = teacherMapper.updateByPrimaryKeySelective(teacher);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }

    }
    //根据主键查询教师信息
    @Override
    public Teacher getTeacherById(Integer id) {
        return teacherMapper.selectByPrimaryKey(id);
    }
    //更新教师
    @Override
    public String updateTeacher(Teacher teacher) {
        //判断用户是否存在
        Teacher hasTea = teacherMapper.selectByUsernameWithoutSelf(teacher);
        if(hasTea != null){
            //已存在
            return "exist";
        }else {
            //不存在
            Integer rows = teacherMapper.updateByPrimaryKeySelective(teacher);
            if(rows == 1){
                return "ok";
            }else {
                return "error";
            }
        }
    }
}
