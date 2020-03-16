package entity;

import java.util.Date;

public class ExamResult {
    private Integer id;

    private Double point;

    private Date time;

    private String examTitle;

    private Integer fkExam;

    private Integer fkStudent;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getPoint() {
        return point;
    }

    public void setPoint(Double point) {
        this.point = point;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getExamTitle() {
        return examTitle;
    }

    public void setExamTitle(String examTitle) {
        this.examTitle = examTitle == null ? null : examTitle.trim();
    }

    public Integer getFkExam() {
        return fkExam;
    }

    public void setFkExam(Integer fkExam) {
        this.fkExam = fkExam;
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