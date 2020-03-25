package entity;

import java.util.Date;

public class WorkCorrecting {
    private Integer id;

    private Date corTime;

    private Double point;

    private Integer fkSubmit;

    private Integer fkTeacher;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCorTime() {
        return corTime;
    }

    public void setCorTime(Date corTime) {
        this.corTime = corTime;
    }

    public Double getPoint() {
        return point;
    }

    public void setPoint(Double point) {
        this.point = point;
    }

    public Integer getFkSubmit() {
        return fkSubmit;
    }

    public void setFkSubmit(Integer fkSubmit) {
        this.fkSubmit = fkSubmit;
    }

    public Integer getFkTeacher() {
        return fkTeacher;
    }

    public void setFkTeacher(Integer fkTeacher) {
        this.fkTeacher = fkTeacher;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}