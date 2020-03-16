package entity;

import java.util.HashMap;
import java.util.Map;

public class ExamAnswer {

    private Integer examId;

    //单选题   id   +   答案
    private Map<Integer, String> singles = new HashMap<>();

    //多选题
    private Map<Integer, String> multis = new HashMap<>();

    //判断题
    private Map<Integer, String> judges = new HashMap<>();


    //提供编辑添加答案的方法
    public void putSingle(Integer key, String value){
        singles.put(key, value);
    }

    public void putMulti(Integer key,String value){
        multis.put(key, value);
    }

    public void putJudge(Integer key,String value){
        judges.put(key, value);
    }


    public Integer getExamId() {
        return examId;
    }

    public void setExamId(Integer examId) {
        this.examId = examId;
    }

    public Map<Integer, String> getSingles() {
        return singles;
    }

    public void setSingles(Map<Integer, String> singles) {
        this.singles = singles;
    }

    public Map<Integer, String> getMultis() {
        return multis;
    }

    public void setMultis(Map<Integer, String> multis) {
        this.multis = multis;
    }

    public Map<Integer, String> getJudges() {
        return judges;
    }

    public void setJudges(Map<Integer, String> judges) {
        this.judges = judges;
    }
}
