package service;

import entity.Manager;

public interface ManagerService {
    /*
    * 登录用，传递管理员的用户名和密码
    * */
    public Manager getManagerByUsernameAndPassword(String username,String password);
}
