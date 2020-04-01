package dto.message;

/**
 * [Create]
 * Description: 消息类型
 * <br/>Date: 2020/3/8 13:43 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
public enum MessageRoleEnum {
    Default(0,"默认")
    , All(-1,"全体")
    , Student(1,"学生")
    , Teacher(2,"教师")
    , Manager(3,"管理员")
    , Clazz(4,"班级")
    ;

    private int code;
    private String desc;

    MessageRoleEnum(int code, String desc){
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
