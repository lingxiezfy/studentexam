package service;

import entity.WorkClazz;

import java.util.List;
import java.util.Map;

public interface WorkClazzService {
    public List<Map> getWorkClazzAllByWorkId(Integer fkWork);

    public String saveWorkClazz(WorkClazz workClazz);

    public String deleteWorkClazz(Integer id);
}
