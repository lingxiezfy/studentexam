package service;

import entity.Grade;

import java.util.List;

public interface GradeService {
    //跳转到年级管理页面
    public List<Grade> getGradeBySelective(String name);
    //删除年级数据
    public String deleteGradeById(Integer gid);
    //保存年级数据
    public String saveGrade(Grade grade);
}
