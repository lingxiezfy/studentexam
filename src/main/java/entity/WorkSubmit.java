package entity;

import java.util.Date;

public class WorkSubmit {
    private Integer id;

    private Date subTime;

    private String workTitle;

    private String fileUrl;

    private Integer fkWork;

    private Integer fkStudent;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getSubTime() {
        return subTime;
    }

    public void setSubTime(Date subTime) {
        this.subTime = subTime;
    }

    public String getWorkTitle() {
        return workTitle;
    }

    public void setWorkTitle(String workTitle) {
        this.workTitle = workTitle == null ? null : workTitle.trim();
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl == null ? null : fileUrl.trim();
    }

    public Integer getFkWork() {
        return fkWork;
    }

    public void setFkWork(Integer fkWork) {
        this.fkWork = fkWork;
    }

    public Integer getFkStudent() {
        return fkStudent;
    }

    public void setFkStudent(Integer fkStudent) {
        this.fkStudent = fkStudent;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}