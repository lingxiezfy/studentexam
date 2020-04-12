package config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/12 17:40 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Configuration
@ComponentScan("config")
@PropertySource({"classpath:exDB.properties"})
@MapperScan(basePackages = "ex.dao",annotationClass=MapperScan.class,sqlSessionFactoryRef  = "exSessionFactory")
public class ExperimentDbConfig {

    @Value("${jdbc.driver}")
    private String driver;
    @Value("${jdbc.url}")
    private String url;
    @Value("${jdbc.username}")
    private String username;
    @Value("${jdbc.password}")
    private String password;


    @Bean(name = "exDBSource")
    public DruidDataSource getHkResourceBean() {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }

    @Bean(name = "exSessionFactory")
    public SqlSessionFactory hkResourceSqlSessionFactory(@Qualifier("exDBSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        bean.setTypeAliasesPackage("ex.entity");
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:/exMapper/*.xml"));
        return bean.getObject();
    }
}