package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * mybatis逆向工程
 * @author Administrator
 *
 */
public class GeneratorSqlMap {

	public void generator() throws Exception{
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        //加载配置文件
        File configFile = new File("src/main/resources/mybatis/mybatis-generator.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,callback, warnings);
        myBatisGenerator.generate(null);

    } 
    public static void main(String[] args) throws Exception {
        try {
            GeneratorSqlMap generatorSqlmap = new GeneratorSqlMap();
            generatorSqlmap.generator();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
