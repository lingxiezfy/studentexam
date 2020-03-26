package web.teacher;

import entity.Student;
import entity.Teacher;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
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

    private static final String REAL_PATH_PARENT = "H:/ideaProjects/studentexam1.0/src/main/webapp/upload";
    private static final String TEMP_PATH_PARENT = "%s/upload";
    private static final String RESOURCE_ROOT = "/resource/teacher_%s";

    @RequestMapping("/classResource")
    public String classResource(){
        return "teacher/class_resource";
    }

    @RequestMapping("/uploadResource")
    @ResponseBody
    public Boolean uploadResource(HttpServletRequest request,HttpSession session){
        // file[]
        // path
        MultipartHttpServletRequest params=((MultipartHttpServletRequest) request);
        List<MultipartFile> files = params.getFiles("file[]");
        String path = params.getParameter("path");
        Teacher teacher = (Teacher)session.getAttribute("user");
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String realResourcePath = REAL_PATH_PARENT+resourceRoot;
        String tempResourcePath = tempPathParent+resourceRoot;

        System.out.println(String.format("上传文件：path:%s,file:%s",path,files != null?files.size():null));
        return false;
    }

    @RequestMapping("/resourceList")
    @ResponseBody
    public Map<String,Object> resourceList(HttpSession session, Integer page, Integer limit){
        Teacher teacher = (Teacher)session.getAttribute("user");
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String tempResourcePath = tempPathParent+resourceRoot;
        String currentPath = "/";
        File rootPath = UploadFileUtils.makeFileDir(tempResourcePath+currentPath);
        File[] files = rootPath.listFiles();
        List<Map> fileListItem = new ArrayList<>();
        if(files != null){
            for (File file : files) {
                Map<String,Object> obj = new HashMap<>();
                obj.put("thumb",currentPath);
                if(file.isDirectory()){
                    obj.put("type","directory");
                    obj.put("path",resourceRoot+currentPath+file.getName());
                }else {
                    obj.put("type", findSuffix(file.getName()));
                }
                fileListItem.add(obj);
            }
        }
        Map<String,Object> response = new HashMap<>();
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

    @RequestMapping("/createFolder")
    @ResponseBody
    public Boolean createFolder(HttpSession session,String folder,String path){
        Teacher teacher = (Teacher)session.getAttribute("user");
        String tempPathParent = String.format(TEMP_PATH_PARENT,session.getServletContext().getRealPath(""));
        String resourceRoot = String.format(RESOURCE_ROOT,teacher.getId());
        String realResourcePath = REAL_PATH_PARENT+resourceRoot;
        String tempResourcePath = tempPathParent+resourceRoot;
        path = path.trim();
        if(StringUtils.isBlank(path)){
            path = "/";
        }else if(!path.startsWith("/")){
            path = ("/"+path);
        }
        String sp;
        if(path.endsWith("/")){
            sp="";
        }else {
            sp = "/";
        }
        UploadFileUtils.makeFileDir(realResourcePath+path+sp+folder);
        UploadFileUtils.makeFileDir(tempResourcePath+path+sp+folder);
        return true;
    }
}
