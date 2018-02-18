
import org.json.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;

public class Main {

    public static String getStr(String address) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(address));
        try {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            String everything = sb.toString();
            return everything;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            br.close();
        }
        return null;
    }

    public static void main(String[] args) {
        int index = Integer.parseInt(args[0]) , last = Integer.parseInt(args[1]) , count = (int)Integer.parseInt(args[2]);
        JSONObject tpsJSON = null;
        try {
            tpsJSON = new JSONObject(getStr("subtasks.json"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        JSONObject tpsSubtasks = tpsJSON.getJSONObject("subtasks");

        int Score = 0;
        for(Iterator iterator = tpsSubtasks.keySet().iterator(); iterator.hasNext();) {
            String key = (String) iterator.next();
            JSONObject sub = tpsSubtasks.getJSONObject(key);
            int ind = sub.getInt("index");
            int score = sub.getInt("score");
            if (ind == index)
                Score = score;
        }
        JSONObject ret = new JSONObject();
        ret.put("score" , Score);
        JSONArray tmp = new JSONArray();
        for (int i = last - count + 1 ; i <= last ; i++)
            tmp.put(i);
        ret.put("tests" , tmp);
        String tmp2 = "";
        if (index != 10)
            tmp2 = ",";
        System.out.println(ret + tmp2);

    }
}
