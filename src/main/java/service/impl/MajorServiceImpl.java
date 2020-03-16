package service.impl;

import entity.Major;
import mapper.MajorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.MajorService;

import java.util.List;

@Service
public class MajorServiceImpl implements MajorService {
    private final byte DEL = 1; //删除
    private final byte ADD = 0; //添加

    @Autowired
    private MajorMapper majorMapper;
    /*
    * 显示专业列表
    * */
    @Override
    public List<Major> getMajorListByName(String name) {
        List<Major> list = majorMapper.selectAllBySelective(name);
        return list;
    }

    /*
    * 删除专业
    * */
    @Override
    public String delMajor(Integer mid) {
        Major major = new Major();
        major.setId(mid);
        major.setDelFlag(DEL);
        Integer count = majorMapper.updateByPrimaryKeySelective(major);
        if(count == 1){
            //删除成功
            return "ok";
        }else{
            //删除失败
            return "error";
        }
    }

    @Override
    public String addMajor(Major major) {
        Major hasMajor = majorMapper.selectByName(major.getName());
        //判断专业是否存在
        if(hasMajor != null){
            //已存在
            if(hasMajor.getDelFlag() == DEL){
                //已存在但已删除
                hasMajor.setDelFlag(ADD);
                majorMapper.updateByPrimaryKeySelective(hasMajor);
                return "ok";
            }else {
                //已存在但未删除
               return "exist";
            }
        }else{
            //不存在
            major.setDelFlag(ADD);
            Integer count = majorMapper.insertSelective(major);
            if(count == 1){
                return "ok";
            }else {
                return "error";
            }
        }
    }
}
