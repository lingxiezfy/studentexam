package service.impl;

import entity.Manager;
import mapper.ManagerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ManagerService;

@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerMapper managerMapper;
    /*
     * 用于登录，根据用户名和姓名查询管理员信息 9.10
     * */
    @Override
    public Manager getManagerByUsernameAndPassword(String username, String password) {
        return managerMapper.selectByUsernameAndPassword(username,password);
    }
}
