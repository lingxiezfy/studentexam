package ex.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
@Mapper
public interface IExDao {

    List<LinkedHashMap<String, Object>> exc(@Param("sql") String sql);

    int up(@Param("sql") String sql);
}
