package util;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.*;

/**
 * [Create]
 * Description:
 */
public class UploadFileUtils {
    private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
    private static final Map<String,String> IMAGE_TYPE_SUFFIX = new HashMap<>();

    static {
        UploadFileUtils.IMAGE_TYPE_SUFFIX.put("jpeg","jpg");
        UploadFileUtils.IMAGE_TYPE_SUFFIX.put("x-icon","ico");
        UploadFileUtils.IMAGE_TYPE_SUFFIX.put("gif","gif");
        UploadFileUtils.IMAGE_TYPE_SUFFIX.put("png","png");
    }

    public static String uploadBase64Image(String base64File,String tempDir,String dir){
        if(base64File == null){
            return null;
        }
        // data:image/png;base64,图片数据
        String[] tempArr = base64File.split(",");
        try {
            // 得到类型 png
            String type = tempArr[0].split("/")[1].split(";")[0];
            if (!UploadFileUtils.IMAGE_TYPE_SUFFIX.containsKey(type)) {
                logger.error(type + ":暂未支持的类型");
                return null;
            }
            String suffix = UploadFileUtils.IMAGE_TYPE_SUFFIX.get(type);
            // 随机生成文件名
            String picName = UUID.randomUUID().toString().replace("-", "") + "." + suffix;
            String imageDate = tempArr[1];
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] imageByte = decoder.decodeBuffer(imageDate);
            for (int i = 0; i < imageByte.length; ++i){
                if (imageByte[i] < 0) {// 调整异常数据
                    imageByte[i] += 256;
                }
            }
            // 临时存储路径
            File tempFilePath = makeFileDir(tempDir);
            // 服务存储路径
            File realPath = makeFileDir(dir);
            // 构建临时的文件（服务器临时目录）
            File tempFile = new File(tempFilePath.getAbsolutePath() + File.separator + picName);
            // 上传图片到 -> “临时路径”
            FileUtils.copyToFile(new ByteArrayInputStream(imageByte),tempFile);
            // 构建真实的文件（永久保存）
            File realFile = new File(realPath.getAbsolutePath() + File.separator + picName);
            // 复制图片到 -> “真实路径”
            FileUtils.copyFile(tempFile,realFile);
            return picName;
        }catch (Exception e){
            logger.error("图片上传失败");
            return null;
        }
    }

    /**
     * 上传文件（多个）
     * @param files List<MultipartFile>
     * @param tempDir 临时路径：String
     * @param realDir 真实路径：String
     * @return 上传成功的文件名列表
     */
    public static List<String> upload(List<MultipartFile> files, String tempDir, String realDir){
        List<String> names = new ArrayList<>();
        // 临时存储路径
        File tempFilePath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        files.stream().filter(Objects::nonNull).forEach(multipartFile->{
            String name;
            if((name = UploadFileUtils.upload(multipartFile,tempFilePath,realPath,null)) != null){
                names.add(name);
            };
        });
        return names;
    }


    /**
     * 上传文件
     * @param multipartFile MultipartFile
     * @param tempDir 临时路径：String
     * @param realDir 真实路径：String
     * @param fileName 文件名（null则随机生成命名）
     * @return 上传成功的文件名
     */
    public static String upload(MultipartFile multipartFile, String tempDir, String realDir,String fileName){
        // 临时存储路径
        File tempPath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        return upload(multipartFile,tempPath,realPath,fileName);
    }

    /**
     * 上传 MultipartFile
     * @param multipartFile MultipartFile
     * @param tempPath 临时路径：File
     * @param realPath 真实路径：File
     * @param fileName 文件名（null则随机生成命名）
     * @return 上传成功的文件名
     */
    private static String upload(MultipartFile multipartFile, File tempPath, File realPath,String fileName){
        // 获取文件后缀(含.号)
        String suffix = multipartFile.getOriginalFilename() == null ? ""
                : multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."));
        if(StringUtils.isEmpty(fileName)){
            // 随机生成文件名
            fileName = UUID.randomUUID().toString().replace("-","")+ suffix;
        }else {
            fileName = fileName.trim()+suffix;
        }
        try {
            // 构建临时的文件（服务器临时目录）
            File tempFile = new File(tempPath.getAbsolutePath() + File.separator + fileName);
            // 上传图片到 -> “临时路径”
            multipartFile.transferTo(tempFile);
            // 构建真实的文件（永久保存）
            File realFile = new File(realPath.getAbsolutePath() + File.separator + fileName);
            // 复制图片到 -> “真实路径”
            FileUtils.copyFile(tempFile,realFile);
            return fileName;
        }catch (Exception e){
            logger.error(multipartFile.getOriginalFilename()+"：上传失败");
        }
        return null;
    }

    /**
     * 创建不存在的文件夹
     * @param dir : String
     * @return dir : File
     */
    private static File makeFileDir(String dir){
        // 构建上传文件的存放 "文件夹" 路径
        String fileDirPath = "";

        File fileDir = new File(dir);
        if(!fileDir.exists()){
            // 递归生成文件夹
            fileDir.mkdirs();
        }
        return fileDir;
    }

}
