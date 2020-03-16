package service.impl;

import entity.TeacherClazz;
import mapper.TeacherClazzMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.TeacherClazzService;

import java.util.List;
import java.util.Map;
@Service
public class TeacherClazzServiceImpl implements TeacherClazzService {
    @Autowired
    private TeacherClazzMapper clazzMapper;
    /*
    * 保存教师和班级的关联信息
    * */
    @Override
    public String saveTeacherClazzService(TeacherClazz tc) {
        String result = "error";
        //关联关系是否已存在
        TeacherClazz hasTc = clazzMapper.selectByFKTeacherAndFKClazz(tc);
        if(hasTc != null){
            //已存在
            result = "exist";
        }else {
            Integer rows = clazzMapper.insert(tc);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
    * 根据教师ID查询所关联的班级信息
    * */
    @Override
    public List<Map> getTeacherClazzAllByTeacherId(Integer teacherId) {
        return clazzMapper.selectByFKTeacher(teacherId);
    }
    /*
    * 删除教师和班级的关联信息
    * */
    @Override
    public String deleteTeacherClazz(Integer tid) {
        Integer rows = clazzMapper.deleteByPrimaryKey(tid);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
}
