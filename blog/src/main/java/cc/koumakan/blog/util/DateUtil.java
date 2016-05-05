package cc.koumakan.blog.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@SuppressWarnings("unchecked & unused")
public class DateUtil {
	/**
	 * 格式化时间 yyyy-MM-dd HH:mm:ss
	 */
	public static String FormatTime(String time) {
		try {
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return s.format(s.parse(time));
		}catch (ParseException e){
			e.printStackTrace();
			return "ERROR";
		}
	}

	/**
	 * 格式化时间 yyyy-MM-dd HH:mm:ss
	 */
	public static String FormatTime(Date time) {
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return s.format(time);
	}

	/**
	 * 格式化时间 yyyy年MM月dd日 HH:mm:ss
	 */
	public static String FormatChineseTime(Date time) {
		SimpleDateFormat s = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		return s.format(time);
	}

	/**
	 * 获得时间段
 	 */
	@SuppressWarnings("deprecated")
	public static String getPart() {
		Date d = new Date();
		int t = d.getHours();
		if (t <= 4)
			return "凌晨";
		else if (t <= 7)
			return "早上";
		else if (t <= 10)
			return "上午";
		else if (t <= 13)
			return "中午";
		else if (t <= 18)
			return "下午";
		else if (t <= 23)
			return "晚上";
		else
			return "您";
	}
}
