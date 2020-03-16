package entity;

public class TeacherClazz {
    private Integer id;

    private Integer fkTeacher;

    private Integer fkClazz;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFkTeacher() {
        return fkTeacher;
    }

    public void setFkTeacher(Integer fkTeacher) {
        this.fkTeacher = fkTeacher;
    }

    public Integer getFkClazz() {
        return fkClazz;
    }

    public void setFkClazz(Integer fkClazz) {
        this.fkClazz = fkClazz;
    }
}