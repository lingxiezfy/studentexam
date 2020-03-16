package service.impl;

import entity.WorkClazz;
import mapper.WorkClazzMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.WorkClazzService;

import java.util.List;
import java.util.Map;

@Service
public class WorkClazzServiceImpl implements WorkClazzService {
    @Autowired
    private WorkClazzMapper clazzMapper;
    private final byte ADD = 0;
    private final byte DEL = 1;
    /*
    *根据作业ID查询关联的班级列表
    * */
    @Override
    public List<Map> getWorkClazzAllByWorkId(Integer fkWork) {
        return clazzMapper.selectByFkWork(fkWork);
    }
    /*
     *保存作业和班级的关联关系
     * */
    @Override
    public String saveWorkClazz(WorkClazz workClazz) {
        String result = "error";
        //判断关联关系是否存在
        WorkClazz hasEc = clazzMapper.selectByFkWorkAndFkClazz(workClazz);
        if(hasEc != null){
            if(hasEc.getDelFlag() == DEL){
                hasEc.setDelFlag(ADD);
                Integer rows = clazzMapper.updateByPrimaryKeySelective(hasEc);
                if(rows == 1){
                    result = "ok";
                }
            }else {
                result = "exist";
            }
        }else {
            workClazz.setDelFlag(ADD);
            Integer rows = clazzMapper.insertSelective(workClazz);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     *删除作业和班级的关联关系
     * */
    @Override
    public String deleteWorkClazz(Integer id) {
        WorkClazz ec = new WorkClazz();
        ec.setId(id);
        ec.setDelFlag(DEL);
        Integer rows = clazzMapper.updateByPrimaryKeySelective(ec);
        if(rows == 1){
            return   "ok";
        }else {
            return "error";
        }

    }
}
