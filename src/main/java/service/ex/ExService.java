package service.ex;

import ex.dao.IExDao;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.*;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/18 15:16 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Component
public class ExService {
    private static final String LINE_SEPARATOR = System.getProperty("line.separator", "\n");
    private static final String DEFAULT_DELIMITER = ";";
    private  String delimiter = ";";

    @Autowired
    IExDao exDao;





    public synchronized List<Map> runScript(InputStreamReader reader) throws IOException {
        List<Map> resultList = new ArrayList<>();
        StringBuilder command = new StringBuilder();
        String line;
        try {
            for(BufferedReader lineReader = new BufferedReader(reader); (line = lineReader.readLine()) != null;) {
                this.handleLine(command, line,resultList);
            }
        }finally {
            this.delimiter = DEFAULT_DELIMITER;
        }
        return resultList;
    }

    private void handleLine(StringBuilder command, String line,List<Map> resultList){
        String trimmedLine = line.trim();
        if (this.lineIsComment(trimmedLine)) {
            String cleanedString = trimmedLine.substring(2).trim().replaceFirst("//", "");
            if (cleanedString.toUpperCase().startsWith("@DELIMITER")) {
                this.delimiter = cleanedString.substring(11, 12);
            }
        } else if (this.commandReadyToExecute(trimmedLine)) {
            int delimiterIndex = line.lastIndexOf(this.delimiter);
            command.append(line, 0, delimiterIndex);
            command.append(LINE_SEPARATOR);
            resultList.add(executeCommand(command));
            command.setLength(0);
            if(delimiterIndex < line.length()-1){
                command.append(line.substring(line.lastIndexOf(this.delimiter)+1));
                command.append(LINE_SEPARATOR);
            }
        } else if (trimmedLine.length() > 0) {
            command.append(line);
            command.append(LINE_SEPARATOR);
        }
    }

    private boolean lineIsComment(String trimmedLine) {
        return trimmedLine.startsWith("//") || trimmedLine.startsWith("--");
    }

    private boolean commandReadyToExecute(String trimmedLine) {
        return trimmedLine.contains(this.delimiter) || trimmedLine.equals(this.delimiter);
    }

    private Map<String,Object> executeCommand(StringBuilder command){
        Map<String,Object> result = new HashMap<>();
        String statement = command.toString();
        result.put("statement",statement);
        long start = System.currentTimeMillis();
        String op = command.substring(0,command.indexOf(" "));
        if(StringUtils.isNotBlank(op)){
            op = op.toLowerCase().trim();
            if("update".equals(op) || "delete".equals(op) || "insert".equals(op)){
                int effectRows = exDao.up(statement);
                result.put("time",System.currentTimeMillis()-start);
                result.put("effectRows",effectRows);
                return result;
            }
        }
        List<LinkedHashMap<String, Object>> rows = exDao.exc(statement);
        result.put("time",System.currentTimeMillis()-start);
        result.put("rows",rows);
        return result;
    }

}
