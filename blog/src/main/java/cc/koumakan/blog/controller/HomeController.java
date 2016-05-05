package cc.koumakan.blog.controller;

import cc.koumakan.blog.entity.Article;
import cc.koumakan.blog.service.ArticleService;
import cc.koumakan.blog.service.ReplyService;
import cc.koumakan.blog.service.UserService;
import cc.koumakan.blog.util.HtmlUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class HomeController {

	@Resource(name = "articleService")
	private ArticleService articleService;
	@Resource(name = "replyService")
	private ReplyService replyService;

	@RequestMapping("/")
	public ModelAndView home0() throws Exception {
		return home();
	}

	@RequestMapping("/home")
	public ModelAndView home() throws Exception {
		ModelAndView mv = new ModelAndView();
		List<String> type = new LinkedList<>();
		type.add("multimedia");
		type.add("program");
		type.add("daily");
		List<Article> articleList = articleService.getByType(type, 0, 10);
		int[] reply_size = new int[articleList.size()];
		for (Article article : articleList) {
			reply_size[articleList.indexOf(article)] = replyService.get(article).size();
		}
		mv.addObject("reply_size", reply_size);
		mv.addObject("current_page", "welcome");
		mv.addObject("articleList", articleList);
		mv.setViewName("home");
		return mv;
	}

	@RequestMapping("/multimedia")
	public ModelAndView multimedia() throws Exception {
		ModelAndView mv = new ModelAndView();
		List<String> type = new LinkedList<>();
		type.add("multimedia");
		List<Article> articleList = articleService.getByType(type, 0, 10);
		int[] reply_size = new int[articleList.size()];
		for (Article article : articleList) {
			reply_size[articleList.indexOf(article)] = replyService.get(article).size();
		}
		mv.addObject("reply_size", reply_size);
		mv.addObject("articleList", articleList);
		mv.addObject("current_page", "multimedia");
		mv.setViewName("home");
		return mv;
	}

	@RequestMapping("/program")
	public ModelAndView program() throws Exception {
		ModelAndView mv = new ModelAndView();
		List<String> type = new LinkedList<>();
		type.add("program");
		List<Article> articleList = articleService.getByType(type, 0, 10);
		int[] reply_size = new int[articleList.size()];
		for (Article article : articleList) {
			reply_size[articleList.indexOf(article)] = replyService.get(article).size();
		}
		mv.addObject("reply_size", reply_size);
		mv.addObject("articleList", articleList);
		mv.addObject("current_page", "program");
		mv.setViewName("home");
		return mv;
	}

	@RequestMapping("/daily")
	public ModelAndView daily() throws Exception {
		ModelAndView mv = new ModelAndView();
		List<String> type = new LinkedList<>();
		type.add("daily");
		List<Article> articleList = articleService.getByType(type, 0, 10);
		int[] reply_size = new int[articleList.size()];
		for (Article article : articleList) {
			reply_size[articleList.indexOf(article)] = replyService.get(article).size();
		}
		mv.addObject("reply_size", reply_size);
		mv.addObject("articleList", articleList);
		mv.addObject("current_page", "daily");
		mv.setViewName("home");
		return mv;
	}

	@RequestMapping(value = "/load_more", produces = {"text/html;charset=UTF-8"})
	@ResponseBody
	public String load_more(HttpServletRequest request) throws Exception {
		String type = request.getParameter("type");
		List<String> type_list = new LinkedList<>();
		Collections.addAll(type_list, type.split(" "));
		int times = Integer.parseInt(request.getParameter("times")) * 10;
		List<Article> articleList = articleService.getByType(type_list, times, 10);
		StringBuilder s = new StringBuilder();
		for (Article article : articleList)
			if (type_list.size() == 1)
				s.append(HtmlUtil.articleTemplate(article, replyService.get(article).size(), false));
			else
				s.append(HtmlUtil.articleTemplate(article, replyService.get(article).size(), true));
		return s.toString();
	}
}
