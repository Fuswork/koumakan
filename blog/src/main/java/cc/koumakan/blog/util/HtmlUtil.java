package cc.koumakan.blog.util;

import cc.koumakan.blog.entity.Article;
import cc.koumakan.blog.service.ReplyService;

import javax.annotation.Resource;
import java.text.ParseException;

@SuppressWarnings("unchecked & unused")
public class HtmlUtil {


	// html转码
	public static String htmlEncode(int i) {
		if (i == '&')
			return "&amp;";
		else if (i == '<')
			return "&lt;";
		else if (i == '>')
			return "&gt;";
		else if (i == '"')
			return "&quot;";
		else if (i == '\n')
			return "<br>";
		else
			return "" + (char) i;
	}

	// 字符串html转码
	public static String htmlEncode(String st) {
		StringBuilder buf = new StringBuilder();
		for (int i = 0; i < st.length(); i++) {
			buf.append(htmlEncode(st.charAt(i)));
		}
		return buf.toString();
	}

	// 界面列表单项模板
	public static String articleTemplate(Article a, int reply_count, boolean type) {
		StringBuilder r = new StringBuilder();
		r.append("<div class='block back-gray' style='padding: 15px 15px 8px;font-size: 16px'>");
		r.append("<span style='white-space:nowrap;text-overflow:ellipsis;overflow:hidden;'>");
		r.append("<a class='white-title' href='/article/");
		r.append(a.getId());
		r.append("' class='title-link'/>");
		r.append(a.getTitle());
		r.append("</a>");
		r.append("</span>");
		r.append("<p style='margin:5px'>");
		r.append(a.getBrief());
		r.append("</p>");
		r.append("<div class='dividing-line' ></div >");
		r.append("<span style='color:#aaaaaa;font-size:12px'>&emsp;");
		r.append(DateUtil.FormatChineseTime(a.getDate()));
		r.append("&emsp;评论:");
		r.append(reply_count);
		if (type) {
			r.append("&emsp;");
			r.append("类型:<a href='/");
			r.append(a.getType());
			r.append("' class='gray'>");
			r.append(a.getType());
			r.append("</a >");
		}
		r.append("&emsp;");
		StringBuilder lable = new StringBuilder();
		for (String s : a.getLabel().split(" ")) {
			lable.append("<a href='/search?label=")
				.append(s)
				.append("' class='gray'>")
				.append(s)
				.append("</a>&nbsp;");
		}
		r.append("标签:");
		r.append(lable.toString());
		r.append("</span>");
		r.append("</div>");
		r.append("<div style='height:10px'></div >");
		return r.toString();
	}
//
//	// 搜索结果单项模板
//	public static String template(Article a, String s) {
//		String left = "<span style='font-weight:300'>[</span>";
//		String right = "<span style='font-weight:300'>]</span>";
//		String r = "";
//		a.setBrief(a.getBrief().replaceAll(s, "<span style='color:#5bc0de'>" + s + "</span>"));
//		a.setType(a.getType().replaceAll(s, "<span style='color:#5bc0de'>" + s + "</span>"));
//		a.setLabel(a.getLabel().replaceAll(s, "<span style='color:#5bc0de'>" + s + "</span>"));
//		a.setTime(a.getTime().replaceAll(s, "<span style='color:#5bc0de'>" + s + "</span>"));
//		r = "<div style='background:#232323;padding:5px;padding-bottom:2px'>"
//				+ "<p style='white-space:nowrap;text-overflow:ellipsis;overflow:hidden;'>"
//				+ "<a href='article/" + a.getId() + "' class='title-link' title=" + a.getTitle() + ">"
//				+ left + a.getType() + right + left + a.getLabel() + right
//				+ a.getTitle().replaceAll(s, "<span style='#5bc0de'>" + s + "</span>")
//				+ "</a>"
//				+ "</p>"
//				+ "<p>" + a.getBrief() + "</p>"
//				+ "<div class='dividing-line' style='margin-top:-5px'></div>"
//				+ "<span style='color:#aaaaaa;font-size:12px'>&emsp;"
//				+ a.getTime()
//				+ "&emsp;&emsp;<span class='glyphicon glyphicon-link'></span>评论:"
//				+ a.getReplaylist().size()
//				+ "</span>"
//				+ "</div>"
//				+ "<div style='height:5px'></div>";
//		return r;
//	}
}
