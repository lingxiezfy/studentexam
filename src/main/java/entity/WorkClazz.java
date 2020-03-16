package entity;

public class WorkClazz {
    private Integer id;

    private Integer fkWork;

    private Integer fkClazz;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFkWork() {
        return fkWork;
    }

    public void setFkWork(Integer fkWork) {
        this.fkWork = fkWork;
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