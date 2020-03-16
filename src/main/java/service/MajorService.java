package service;

import entity.Major;

import java.util.List;

public interface MajorService {
    //根据姓名查询专业（传递数据到下拉框）
    public List<Major> getMajorListByName(String name);
    //删除专业信息
    public String delMajor(Integer mid);
    //添加专业
    public String addMajor(Major major);
}
