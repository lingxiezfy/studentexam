package service;

import entity.Clazz;

import java.util.List;
import java.util.Map;

public interface ClazzService {
    //显示班级列表
    public List<Map> getClazzAllByGradeAndMajor(String gradeName,String majorName);
    //添加班级及保存
    public String saveClazz(Clazz clazz);
    //删除班级信息
    public String deleteClazz(Integer cid);
    //根据姓名查询班级（传递数据到下拉框）
    public List<Clazz> getClazzAllByGradeIdAndMajorId(Integer gradeId,Integer majorId);

    public Clazz selectById(Integer cid);
}
