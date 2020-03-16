package service.impl;

import entity.Student;
import mapper.StudentMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.StudentService;
import util.MD5Util;

import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    private final byte DEL = 1;
    private final byte ADD = 0;
    private final byte MODIFIED = 0; //0表示修改密码，1表示未修改
    private String DEFAULT_PASSWORD = "111111";
    /*
     * 根据用户名和姓名查询学生信息 9.10
     * */
    @Override
    public Student getStudentByUsernameAndPassword(String username, String password) {
        return studentMapper.selectByUsernameAndPassword(username,password);
    }
    /*
    *根据条件查询学生列表
    * */
    @Override
    public List<Map> selectStudentListBySelective(String gradeName, String majorName, String realname) {
        //模糊查询
        if(StringUtils.isNotBlank(gradeName)){
            gradeName = "%"+gradeName+"%";
        }
        if(StringUtils.isNotBlank(majorName)){
            majorName = "%"+majorName+"%";
        }
        if(StringUtils.isNotBlank(realname)){
            realname = "%"+realname+"%";
        }
        return studentMapper.selectAllBySelective(gradeName, majorName, realname);
    }
    /*
    * 删除学生
    * */
    @Override
    public String deleteStudent(Integer sid) {
        Student student = new Student();
        student.setId(sid);
        student.setDelFlag(DEL);
        Integer count = studentMapper.updateByPrimaryKeySelective(student);
        if(count == 1){
            return "ok";
        }else{
            return "error";
        }
    }
    /*
    * 添加学生
    * */
    @Override
    public String insertStudent(Student student) {
        String result = "error";
        Student hasStudent = studentMapper.selectByUsername(student.getUsername());
        if(hasStudent != null){
            //已存在，但已经被删除
            if(hasStudent.getDelFlag() == DEL){
                hasStudent.setDelFlag(ADD);
                hasStudent.setModified(MODIFIED);
                hasStudent.setPassword(MD5Util.getMD5(DEFAULT_PASSWORD));
                Integer count = studentMapper.updateByPrimaryKeySelective(hasStudent);
                if(count == 1){
                    result = "ok";
                }
            }else{
                //已存在
                result = "exist";
            }
        }else {
            //新增
            student.setDelFlag(ADD);
            student.setModified(MODIFIED);
            student.setPassword(MD5Util.getMD5(DEFAULT_PASSWORD));
            Integer count = studentMapper.insertSelective(student);
            if(count == 1){
                //保存成功
                result = "ok";
            }

        }
        return result;
    }

    /*
    * 根据主键查询学生信息
    * */
    @Override
    public Student selectById(Integer id) {
        return studentMapper.selectByPrimaryKey(id);
    }

    /*
    * 更新学生信息
    * */
    @Override
    public String updateStudent(Student student) {
        String result = "error";
        Student hasStudent = studentMapper.selectByUsernameWithoutSelf(student.getUsername(),student.getId());
        if(hasStudent != null){
            //已存在，只要在数据库中能查到该用户名，即使该用户名的删除表示1，也算用户名重复
            result = "exist";
        }else {
            //更新
            Integer count = studentMapper.updateByPrimaryKeySelective(student);
            if(count == 1){
                result = "ok";
            }
        }
        return result;
    }
}
