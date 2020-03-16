package entity;

public class ExamClazz {
    private Integer id;

    private Integer fkExam;

    private Integer fkClazz;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFkExam() {
        return fkExam;
    }

    public void setFkExam(Integer fkExam) {
        this.fkExam = fkExam;
    }

    public Integer getFkClazz() {
        return fkClazz;
    }

    public void setFkClazz(Integer fkClazz) {
        this.fkClazz = fkClazz;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}