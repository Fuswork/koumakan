package cc.koumakan.blog.controller;

import cc.koumakan.blog.entity.Article;
import cc.koumakan.blog.entity.Reply;
import cc.koumakan.blog.entity.User;
import cc.koumakan.blog.service.ArticleService;
import cc.koumakan.blog.service.ReplyService;
import cc.koumakan.blog.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SearchController {

	@Resource(name = "articleService")
	private ArticleService articleService;
	@Resource(name = "replyService")
	private ReplyService replyService;
	@Resource(name = "userService")
	private UserService userService;

	@RequestMapping("/search")
	public void search(HttpServletResponse response) throws Exception {
		response.sendError(403, "搜索系统未开放。。。");
//		ModelAndView mv = new ModelAndView();
//		// 获得搜索信息
//		String search_data = request.getParameter("search_data");
//		// 处理搜索页面显示
//		// 无输入
//		if (search_data == null || search_data.equals("")) {
//			mv.addObject("isnull", true);
//		} else {
//			mv.addObject("search_data", search_data);
//			mv.addObject("title", "-" + search_data);
//			mv.addObject("isnull", false);
//		}
//		mv.addObject("current_page", "search");
//		mv.setViewName("search");
//		return mv;
	}

	@RequestMapping("/search_search")
	@ResponseBody
	public Map<String, String> search_content(HttpServletRequest request) throws Exception {
		Map<String, String> mv = new HashMap<>();
		String content_div = "";
		// 获得搜索信息
		String search_data = request.getParameter("search_data");
		String search_type = request.getParameter("search_type");
		String search_time = request.getParameter("search_time");

		// 搜索开始
		long time = System.currentTimeMillis();
//		for (Article a : articleService.getByType("('multimedia')")) {
//			content_div += a;
//		}
		time = System.currentTimeMillis() - time;
		// 搜索结束

		mv.put("content_div", content_div);
		mv.put("time", String.valueOf((float) time / 1000));
		mv.put("isnull", "false");
		return mv;
	}

	@RequestMapping("/article/{id}")
	public ModelAndView search(HttpServletResponse response, @PathVariable String id) throws Exception {
		ModelAndView mv = new ModelAndView();
		Article a = articleService.getById(id);
		if (a == null) {
			response.sendError(404, "未找到该文章");
			return null;
		}
		// 上一篇
		Article pre = articleService.getPre(id);
		// 下一篇
		Article next = articleService.getNext(id);
		List<Reply> replies = replyService.get(a);
		for (Reply reply : replies)
			mv.addObject("user_" + reply.getUserid(), userService.getUserById(reply.getUserid()).getUsername());
		mv.addObject("article", a);
		mv.addObject("pre_article", pre);
		mv.addObject("next_article", next);
		mv.addObject("replies", replies);
		mv.setViewName("article");
		return mv;
	}

	@RequestMapping(value = "/reply", produces = {"text/html;charset=UTF-8"})
	@ResponseBody
	public String addReply(HttpServletRequest request) {
		try {
			String s = request.getParameter("content");
			if (s.equals("")) return "null";
			Reply reply = new Reply();
			reply.setArticleid(Integer.parseInt(request.getParameter("article_id")));
			reply.setContent(s);
			User user = (User) request.getSession().getAttribute("user");
			reply.setUserid(user.getId());
			reply.setDate(new Date());
			replyService.add(reply);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
	}
}
