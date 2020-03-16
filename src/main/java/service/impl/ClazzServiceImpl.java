package service.impl;

import entity.Clazz;
import mapper.ClazzMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ClazzService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ClazzServiceImpl implements ClazzService {

    @Autowired
    private ClazzMapper clazzMapper;

    private final byte DEL = 1; //删除标记
    private final byte ADD = 0; //添加标记

    /*
    * 查询班级列表
    * */
    @Override
    public List<Map> getClazzAllByGradeAndMajor(String gradeName, String majorName) {
        //模糊查询
        if(StringUtils.isNotBlank(gradeName)){
            gradeName = "%"+gradeName+"%";
        }
        if(StringUtils.isNotBlank(majorName)){
            majorName = "%"+majorName+"%";
        }
        return clazzMapper.selectAllByGradeAndMajor(gradeName, majorName);
    }
    /*
     * 保存班级信息
     * */
    @Override
    public String saveClazz(Clazz clazz) {
        String result = "error";
        //判断该班级是否已经存在（年级 专业 班级编号相同则存在）
        Clazz hasClazz = clazzMapper.selectOneExist(clazz);
        if(hasClazz != null){
            //已存在，但已删除
            if(hasClazz.getDelFlag() == DEL){
                hasClazz.setDelFlag(ADD);
                Integer count = clazzMapper.updateByPrimaryKeySelective(hasClazz);
                if(count == 1){
                    result = "ok";
                }else {
                    result = "exist";
                }
            }
        }else{
            //新增
            clazz.setDelFlag(ADD);
            Integer count = clazzMapper.insertSelective(clazz);
            if(count == 1){
                result = "ok";
            }
        }

        return result;
    }
    /*
    * 删除班级
    * */
    @Override
    public String deleteClazz(Integer cid) {
        Clazz clazz = new Clazz();
        clazz.setId(cid);
        clazz.setDelFlag(DEL);
        Integer count = clazzMapper.updateByPrimaryKeySelective(clazz);
        if(count == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    //根据专业和年级的id查询班级
    @Override
    public List<Clazz> getClazzAllByGradeIdAndMajorId(Integer gradeId, Integer majorId) {
        List<Clazz> clazz = clazzMapper.selectAllGradeIdAndMajorId(gradeId, majorId);
        return clazz;
    }
    /*
    * 通过ID查询班级信息
    * */
    @Override
    public Clazz selectById(Integer cid) {

        return clazzMapper.selectByPrimaryKey(cid);
    }


}
