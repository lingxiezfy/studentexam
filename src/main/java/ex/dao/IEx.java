package ex.dao;

import org.mybatis.spring.annotation.MapperScan;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/12 18:53 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@MapperScan
public interface IEx {

    List<LinkedHashMap<String, Object>> exc(String sql);
}
