package service.impl;

import entity.Menu;
import mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.MenuService;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;
    /*
    * 根据角色id查询菜单
    * */
    @Override
    public List<Menu> getMenuByRoleId(Integer id) {
        return menuMapper.selectByRoleId(id);
    }
}
