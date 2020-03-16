package entity;

public class Clazz {
    private Integer id;

    private Integer cno;

    private Integer fkGrade;

    private Integer fkMajor;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCno() {
        return cno;
    }

    public void setCno(Integer cno) {
        this.cno = cno;
    }

    public Integer getFkGrade() {
        return fkGrade;
    }

    public void setFkGrade(Integer fkGrade) {
        this.fkGrade = fkGrade;
    }

    public Integer getFkMajor() {
        return fkMajor;
    }

    public void setFkMajor(Integer fkMajor) {
        this.fkMajor = fkMajor;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}