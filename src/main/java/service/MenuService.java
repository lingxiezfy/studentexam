package service;

import entity.Menu;

import java.util.List;

public interface MenuService {
    //页面左边的菜单信息
    public List<Menu> getMenuByRoleId(Integer id);
}
