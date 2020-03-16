package util;

import java.util.HashMap;
import java.util.Map;

/**
 * 分页用参数保存工具类
 * @author Administrator
 * 2019-09-11 11:32
 */
public class ParamUtil {

	
	public static Map<String,Object> params = new HashMap<String,Object>();
	/**
	 * 添加参数
	 * @param key
	 * @param value
	 */
	public static void addParam(String key,Object value){
		params.put(key, value);
	}
	
	/**
	 * 清空参数
	 */
	public static void clear(){
		params.clear();
	}
}
