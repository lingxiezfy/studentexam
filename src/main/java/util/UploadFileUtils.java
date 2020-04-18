package util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
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
     * @see  UploadFileUtils#upload(MultipartFile, File, File, String, boolean, boolean)
     */
    public static List<UploadResult> upload(List<MultipartFile> files, String tempDir, String realDir){
        List<UploadResult> results = new ArrayList<>();
        // 临时存储路径
        File tempFilePath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        files.stream().filter(Objects::nonNull).forEach(multipartFile->{
            results.add(UploadFileUtils.upload(multipartFile,tempFilePath,realPath,UUID.randomUUID().toString().replace("-",""),false,true));
        });
        return results;
    }


    /**
     * 上传文件
     * @see  UploadFileUtils#upload(MultipartFile, File, File, String, boolean, boolean)
     */
    public static UploadResult upload(MultipartFile multipartFile, String tempDir, String realDir,String fileName){
        // 临时存储路径
        File tempPath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        return upload(multipartFile,tempPath,realPath,fileName,true,false);
    }

    /**
     * 上传文件
     * @see  UploadFileUtils#upload(MultipartFile, File, File, String, boolean, boolean)
     */
    public static UploadResult upload(MultipartFile multipartFile, String tempDir, String realDir,String fileName,boolean withSuffix){
        // 临时存储路径
        File tempPath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        return upload(multipartFile,tempPath,realPath,fileName,withSuffix,false);
    }

    /**
     * 上传文件
     * @see  UploadFileUtils#upload(MultipartFile, File, File, String, boolean, boolean)
     */
    public static UploadResult upload(MultipartFile multipartFile, String tempDir, String realDir,String fileName,boolean withSuffix,boolean repeatAble){
        // 临时存储路径
        File tempPath = makeFileDir(tempDir);
        // 服务存储路径
        File realPath = makeFileDir(realDir);
        return upload(multipartFile,tempPath,realPath,fileName,withSuffix,repeatAble);
    }

    /**
     * 上传 MultipartFile
     * @param multipartFile MultipartFile
     * @param tempPath 临时路径：File
     * @param realPath 真实路径：File
     * @param customizeName 自定义文件名
     *                 null则使用源文件名
     * @param withSuffix 给定的文件名是否含有后缀
     *                   fileName 不为空的时候有效
     *                   当给定的文件名没有后缀时，即使 withSuffix 参数值为true也不会生效
     *                   （除非源文件也没有后缀，才有可能成功上传一个不带后缀的文件）
     * @param repeatAble 是否允许重复
     *                   允许重复时，将在文件名末尾添加 (1)
     *                   不允许时，跳过文件拒绝添加文件
     * @return 上传结果
     */
    private static UploadResult upload(MultipartFile multipartFile
            , File tempPath
            , File realPath
            ,String customizeName
            ,boolean withSuffix
            ,boolean repeatAble){
        String originName = multipartFile.getOriginalFilename() == null
                ? UUID.randomUUID().toString().replace("-","")
                : multipartFile.getOriginalFilename().trim();
        int dotIndex =  originName.lastIndexOf(".");
        // 获取源文件后缀(不包含.号)
        String suffix = dotIndex > -1 ? originName.substring(dotIndex+1) : "";
        // 获取源文件名(不包含.号和后缀)
        String fileName = dotIndex == -1 ? originName : originName.substring(0, dotIndex);
        // 给定了文件名
        if(StringUtils.isNotBlank(customizeName)) {
            customizeName = customizeName.trim();
            if (withSuffix) { // 检查是否有可用后缀
                dotIndex = customizeName.lastIndexOf(".");
                if (dotIndex == -1) {
                    withSuffix = false;
                } else if (dotIndex == customizeName.length() - 1) {
                    withSuffix = false;
                    customizeName = customizeName.substring(0, dotIndex);
                }
            }
            if (withSuffix) { // 确定存在后缀
                fileName = customizeName.substring(0, dotIndex);
                suffix = customizeName.substring(dotIndex + 1);
            } else { // 未给定后缀，或者给定的后缀无效，使用源文件的后缀
                fileName = customizeName;
            }
        }
        UploadFileUtils.UploadResult result = new UploadFileUtils.UploadResult();
        String suffixWithDot = StringUtils.isNotBlank(suffix) ? ("."+suffix):"";
        try {
            // 构建真实的文件（永久保存）
            File realFile = new File(realPath.getAbsolutePath() + File.separator + fileName + suffixWithDot);
            // 复制图片到 -> “真实路径”
            if(realFile.exists()){
                if(repeatAble){
                    realFile = saveFileForRepeat(multipartFile,realFile,realPath.getAbsolutePath(),fileName,suffixWithDot);
                }else {
                    result.uploadMessage = "上传失败，存在重复文件";
                    logger.error("文件上传，源文件:{}，上传文件:{}，上传失败，存在重复文件"
                            ,multipartFile.getOriginalFilename()
                            ,realFile.getAbsolutePath());
                    return result;
                }
            }else {
                multipartFile.transferTo(realFile);
            }
            // 构建临时的文件（服务器临时目录）
            File tempFile = new File(tempPath.getAbsolutePath() + File.separator + realFile.getName());
            // 复制图片到 -> “临时路径”（以便本地服务访问）
            FileUtils.copyFile(realFile,tempFile);

            String fileRealName = realFile.getName();
            dotIndex = fileRealName.lastIndexOf(".");
            result.fileName = dotIndex == -1 ? fileRealName : fileRealName.substring(0, dotIndex);
            result.suffix =  dotIndex > -1 ? fileRealName.substring(dotIndex+1) : "";
            result.fileRealName = fileRealName;
            result.isSuccess = true;
            result.uploadMessage = "上传成功";
            return result;
        }catch (Exception e){
            logger.error("文件上传，源文件:{}，上传文件名：{}，上传路径:{}，上传失败，发生异常：{}"
                    ,multipartFile.getOriginalFilename()
                    ,fileName + suffixWithDot
                    ,realPath.getAbsolutePath()
                    ,e);
            result.uploadMessage = "上传失败，系统错误";
            return result;
        }
    }

    private static File saveFileForRepeat(MultipartFile origin,File target,String savePath,String fileName,String suffixWithDot) throws IOException {
        if(target.exists()){
            fileName = fileName+"(1)";
            return saveFileForRepeat(
                    origin
                    ,new File(savePath + File.separator + fileName + suffixWithDot)
                    ,savePath
                    ,fileName
                    ,suffixWithDot
            );
        }else {
            origin.transferTo(target);
            return target;
        }
    }

    public static class UploadResult{
        String fileName = null;
        String suffix = null;
        String fileRealName = null;
        String uploadMessage = "上传失败";
        boolean isSuccess = false;

        public String getFileName() {
            return fileName;
        }

        public void setFileName(String fileName) {
            this.fileName = fileName;
        }

        public String getSuffix() {
            return suffix;
        }

        public void setSuffix(String suffix) {
            this.suffix = suffix;
        }

        public String getFileRealName() {
            return fileRealName;
        }

        public void setFileRealName(String fileRealName) {
            this.fileRealName = fileRealName;
        }

        public String getUploadMessage() {
            return uploadMessage;
        }

        public void setUploadMessage(String uploadMessage) {
            this.uploadMessage = uploadMessage;
        }

        public boolean isSuccess() {
            return isSuccess;
        }

        public void setSuccess(boolean success) {
            isSuccess = success;
        }
    }

    /**
     * 创建不存在的文件夹
     * @param dir : String
     * @return dir : File
     */
    public static File makeFileDir(String dir){
        // 构建上传文件的存放 "文件夹" 路径
        File fileDir = new File(dir);
        if(!fileDir.exists()){
            // 递归生成文件夹
            fileDir.mkdirs();
        }
        return fileDir;
    }

}
