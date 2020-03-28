package web.teacher;

import entity.Student;
import entity.Teacher;
import mapper.TeacherMapper;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import util.UploadFileUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * [Create]
 * Description: 课堂资源管理
 * <br/>Date: 2020/3/26 23:29 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@RequestMapping("teacher")
@Controller
public class ClassResourceController {

    private static final String REAL_PATH_PARENT = "H:/ideaProjects/studentexam1.0/src/main/webapp/";
    private static final String TEMP_PATH_PARENT = "%s/";
    private static final String RESOURCE_ROOT = "upload/resource/teacher_%s";

    @RequestMapping("/classResource")
    public String classResource(){
        return "teacher/class_resource";
    }

    /**
     * 上传文件至教师本人根目录
     */
    @RequestMapping("/uploadResource")
    @ResponseBody
    public Boolean uploadResource(HttpServletRequest request,HttpSession session){
        MultipartHttpServletRequest params=((MultipartHttpServletRequest) request);
        List<MultipartFile> files = params.getFiles("file[]");
        String path = params.getParameter("path");
        if(files != null && files.size() > 0){
            Teacher teacher = (Teacher)session.getAttribute("user");
            String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
            String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
            String realResourcePath = REAL_PATH_PARENT+resourceRoot;
            String tempResourcePath = tempPathParent+resourceRoot;
            if(StringUtils.isNotBlank(path)){
                // 首部添加 "/"
                if(!path.startsWith("/")){
                    path = ("/"+path.trim());
                }
                //去除 末尾"/"
                if(path.endsWith("/")){
                    path = path.substring(0,path.length()-1);
                }
            }
            String finalPath = path;
            files.forEach(file->{
                UploadFileUtils.upload(file, tempResourcePath + finalPath, realResourcePath + finalPath, null, false, true);
            });
        }
        return false;
    }

    /**
     * 上传文件至教师本人根目录
     */
    @RequestMapping("/deleteResource")
    @ResponseBody
    public Boolean deleteResource(String parent,String name,HttpSession session){
        if(StringUtils.isBlank(name)){
            return false;
        }
        Teacher teacher = (Teacher)session.getAttribute("user");
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String realResourcePath = REAL_PATH_PARENT+resourceRoot;
        String tempResourcePath = tempPathParent+resourceRoot;
        if(StringUtils.isBlank(parent)){
            parent = "/";
        }else if(!parent.startsWith("/")){
            parent = ("/"+parent.trim());
        }
        String sp;
        if(parent.endsWith("/")){
            sp="";
        }else {
            sp = "/";
        }
        try {
            File tempFile = new File(tempResourcePath + parent + sp + name);
            if(tempFile.exists()){
                FileUtils.forceDelete(tempFile);
            }
            File realFile = new File(realResourcePath + parent + sp + name);
            if(realFile.exists()){
                FileUtils.forceDelete(realFile);
            }
        }catch (Exception e){
            return false;
        }
        return true;
    }

    /**
     * 浏览教师本人的资源
     */
    @RequestMapping("/resourceList")
    @ResponseBody
    public Map<String,Object> resourceList(HttpSession session, String path){
        Map<String,Object> response = new HashMap<>();
        response.put("data",new ArrayList<>());
        response.put("code",1);
        response.put("count",0);
        Teacher teacher = (Teacher)session.getAttribute("user");
        if(teacher == null){
            response.put("msg","登录信息无效，无法浏览资源");
            return response;
        }
        return resourceList(session,teacher,path);
    }

    @Autowired
    TeacherMapper teacherMapper;

    /**
     * 浏览指定教师的资源
     */
    @RequestMapping("/selectResource")
    @ResponseBody
    public Map<String,Object> resourceList(HttpSession session,Integer teacherId,String path){
        Map<String,Object> response = new HashMap<>();
        response.put("data",new ArrayList<>());
        response.put("code",1);
        response.put("count",0);
        if(teacherId == null || teacherId <= 0){
            response.put("msg","请选择教师进行资源浏览");
            return response;
        }
        Teacher teacher = teacherMapper.selectByPrimaryKey(teacherId);
        if(teacher == null){
            response.put("msg","选择的教师无效");
            return response;
        }
        return resourceList(session,teacher,path);
    }


    private Map<String,Object> resourceList(HttpSession session,Teacher teacher,String path){
        Map<String,Object> response = new HashMap<>();
        if(teacher == null){
            response.put("data",new ArrayList<>());
            response.put("code",1);
            response.put("count",0);
            response.put("msg","教师无效,无法查看资源");
            return response;
        }
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String tempResourcePath = tempPathParent+resourceRoot;
        if(StringUtils.isBlank(path)){
            path = "/";
        }else if(!path.startsWith("/")){
            path = ("/"+path.trim());
        }
        String sp;
        if(path.endsWith("/")){
            sp="";
        }else {
            sp = "/";
        }
        File rootPath = UploadFileUtils.makeFileDir(tempResourcePath+path);
        File[] files = rootPath.listFiles();
        List<Map> fileListItem = new ArrayList<>();
        if(files != null){
            for (File file : files) {
                Map<String,Object> obj = new HashMap<>();
                obj.put("thumb",resourceRoot+path+sp+file.getName()); //文件路径
                obj.put("name",file.getName()); // 文件名
                if(file.isDirectory()){
                    obj.put("type","directory"); // 文件类型
                    obj.put("path",path+sp+file.getName()+"/"); // 文件路径
                }else {
                    obj.put("type", findSuffix(file.getName()));
                    obj.put("path",path+sp);
                }
                fileListItem.add(obj);
            }
        }
        response.put("data",fileListItem);
        response.put("code",0);
        response.put("count",fileListItem.size());
        return response;
    }


    private String findSuffix(String fileName){
        int index =  fileName.lastIndexOf(".");
        if (index >= 0 && index < fileName.length() - 1) {
            return fileName.substring(index+1);
        }
        return "";
    }

    /**
     * 新建文件夹
     */
    @RequestMapping("/createFolder")
    @ResponseBody
    public Map<String,Object> createFolder(HttpSession session,String folder,String path){
        Map<String,Object> response = new HashMap<>();
        if(!validFolder(folder)){
            response.put("success",false);
            response.put("msg","新建文件夹失败，文件夹命名有误");
            return response;
        }
        Teacher teacher = (Teacher)session.getAttribute("user");
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String realResourcePath = REAL_PATH_PARENT+resourceRoot;
        String tempResourcePath = tempPathParent+resourceRoot;
        if(StringUtils.isBlank(path)){
            path = "/";
        }else if(!path.startsWith("/")){
            path = ("/"+path.trim());
        }
        String sp;
        if(path.endsWith("/")){
            sp="";
        }else {
            sp = "/";
        }
        UploadFileUtils.makeFileDir(realResourcePath+path+sp+folder);
        UploadFileUtils.makeFileDir(tempResourcePath+path+sp+folder);

        response.put("success",true);
        response.put("msg","新建文件夹成功，请及时上传文件，服务器将不定时清除空文件夹");
        return response;
    }

    private boolean validFolder(String folder) {
        return StringUtils.isNotBlank(folder);
    }
}
