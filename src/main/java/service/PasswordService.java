package service;


import javax.servlet.http.HttpSession;


public interface PasswordService {
    //更改密码
    public String updatePwd(String oldPwd, String newPwd, HttpSession session);
}
