package service.impl;

import entity.ExamClazz;
import mapper.ExamClazzMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ExamClazzService;

import java.util.List;
import java.util.Map;

@Service
public class ExamClazzServiceImpl implements ExamClazzService {
    @Autowired
    private ExamClazzMapper clazzMapper;
    private final byte ADD = 0;
    private final byte DEL = 1;
    /*
    *根据试卷ID查询关联的班级列表
    * */
    @Override
    public List<Map> getExamClazzAllByExamId(Integer fkExam) {
        return clazzMapper.selectByFkExam(fkExam);
    }
    /*
     *保存试卷和班级的关联关系
     * */
    @Override
    public String saveExamClazz(ExamClazz examClazz) {
        String result = "error";
        //判断关联关系是否存在
        ExamClazz hasEc = clazzMapper.selectByFkExamAndFkClazz(examClazz);
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
            examClazz.setDelFlag(ADD);
            Integer rows = clazzMapper.insertSelective(examClazz);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     *删除试卷和班级的关联关系
     * */
    @Override
    public String deleteExamClazz(Integer id) {
        ExamClazz ec = new ExamClazz();
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
