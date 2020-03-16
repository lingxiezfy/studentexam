package service.impl;

import entity.Grade;
import mapper.GradeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.GradeService;

import java.util.List;
@Service
public class GradeServiceImpl implements GradeService {
    private final byte DEL = 1; //删除
    private final byte ADD = 0; //添加
    @Autowired
    private GradeMapper gradeMapper;
    /*
     * 跳转到年级管理页面
     * */
    @Override
    public List<Grade> getGradeBySelective(String name) {
        List<Grade> list = gradeMapper.selectAllBySelective(name);
        return list;
    }

    /*
     * 删除年级数据
     * */
    @Override
    public String deleteGradeById(Integer gid) {
        Grade grade = new Grade();
        grade.setId(gid);
        grade.setDelFlag(DEL);
        Integer count = gradeMapper.updateByPrimaryKeySelective(grade);
        if(count == 1){
            //删除成功
            return "ok";
        }else{
            //删除失败
            return "error";
        }
    }
    /*
     *添加年级数据
     * */
    @Override
    public String saveGrade(Grade grade) {
        //判断该年级是否存在
        Grade hasGrade = gradeMapper.selectByName(grade.getName());
        if(hasGrade != null){
            if(hasGrade.getDelFlag() == DEL){
                //已存在但被删除
                hasGrade.setDelFlag(ADD);
                gradeMapper.updateByPrimaryKeySelective(hasGrade);
                return "ok";
            }else{
                //已存在未删除
                return "exist";
            }
        }else {
            //不存在
            grade.setDelFlag(ADD);
            Integer count = gradeMapper.insertSelective(grade);
            if(count == 1){
                return "ok";
            }else {
                return "error";
            }

        }

    }
}
