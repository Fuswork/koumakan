package cc.koumakan.blog.controller;

import cc.koumakan.blog.entity.About;
import cc.koumakan.blog.entity.Contact;
import cc.koumakan.blog.entity.Navigate;
import cc.koumakan.blog.entity.User;
import cc.koumakan.blog.service.AboutService;
import cc.koumakan.blog.service.ContactService;
import cc.koumakan.blog.service.NavigateService;
import cc.koumakan.blog.util.DateUtil;
import cc.koumakan.blog.util.SystemUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AboutController {

	@Resource(name = "aboutService")
	private AboutService aboutService;
	@Resource(name = "navigateService")
	private NavigateService navigateService;
	@Resource(name = "contactService")
	private ContactService contactService;

	private About aa;

	// 关于网站
	@RequestMapping("/about_site")
	public ModelAndView home() throws Exception {
		ModelAndView mv = new ModelAndView();
		aa = aboutService.findByTitle("关于本站");
		mv.addObject("title", aa.getTitle());
		mv.addObject("content", aa.getContent());
		mv.addObject("time", DateUtil.FormatChineseTime(aa.getDate()));
		mv.addObject("author", aa.getAuthor());
		mv.setViewName("about/about");
		return mv;
	}

	// 关于作者
	@RequestMapping("/about_author")
	public ModelAndView home2() throws Exception {
		ModelAndView mv = new ModelAndView();
		aa = aboutService.findByTitle("关于作者");
		mv.addObject("title", aa.getTitle());
		mv.addObject("content", aa.getContent());
		mv.addObject("time", DateUtil.FormatChineseTime(aa.getDate()));
		mv.addObject("author", aa.getAuthor());
		mv.setViewName("about/about");
		return mv;
	}

	// 免责声明
	@RequestMapping("/about_anno")
	public ModelAndView home3() throws Exception {
		ModelAndView mv = new ModelAndView();
		aa = aboutService.findByTitle("免责声明");
		mv.addObject("title", aa.getTitle());
		mv.addObject("content", aa.getContent());
		mv.addObject("time", DateUtil.FormatChineseTime(aa.getDate()));
		mv.addObject("author", aa.getAuthor());
		mv.setViewName("about/about");
		return mv;
	}

	// 网站地图
	@RequestMapping("/map")
	public ModelAndView home6() throws Exception {
		ModelAndView mv = new ModelAndView();
		aa = aboutService.findByTitle("网站地图");
		mv.addObject("title", aa.getTitle());
		mv.addObject("content", aa.getContent());
		mv.addObject("time", DateUtil.FormatChineseTime(aa.getDate()));
		mv.addObject("author", aa.getAuthor());
		mv.setViewName("about/about");
		return mv;
	}

	// 联系作者
	@RequestMapping("/contact_author")
	public ModelAndView home4() throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", "联系作者");
		mv.setViewName("about/contact");
		return mv;
	}

	// 意见反馈
	@RequestMapping("/contact_advice")
	public ModelAndView home5() throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", "意见反馈");
		mv.setViewName("about/contact");
		return mv;
	}

	// 意见反馈
	@RequestMapping("/contact_contact")
	@ResponseBody
	public String contact(HttpServletRequest request) throws Exception {
		if (request.getParameter("title").equals("") && request.getParameter("content").equals("")) {
			return "null";
		}
		Contact contact = new Contact();
		contact.setTitle(request.getParameter("title"));
		contact.setContent(request.getParameter("content"));
		contact.setEmail(request.getParameter("email"));
		// 获得ip
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else
			ip = request.getHeader("x-forwarded-for");
		// 获得username
		User user = (User) request.getSession().getAttribute("user");
		String name = request.getParameter("name") + ":" + user.getId();
		contact.setName(name);
		contact.setIp(ip);
		// 获得时间
		contact.setDate(new Date());
		contactService.add(contact);
		return "success";
	}

	// 服务器负载
	@RequestMapping("/load")
	public ModelAndView home7(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		User user = (User) request.getSession().getAttribute("user");
		if (user.getId() != 0) {
			mv.setViewName("about/load");
			return mv;
		} else {
			return new ModelAndView("redirect:/login?type=refuse");
		}
	}

	// 服务器负载信息
	@RequestMapping("/load_data")
	@ResponseBody
	public Object load(HttpServletRequest request) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		if (user.getId() != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memory", SystemUtil.memory());
			map.put("cpu", SystemUtil.cpu());
			map.put("jvm", SystemUtil.jvm());
			return map;
		} else {
			return "请登录后发出请求";
		}
	}

	// 左侧导航
	@RequestMapping(value = "/left")
	@ResponseBody
	public Map<String, Object> get() throws Exception {
		Map<String, Object> map = new HashMap<>();
		for (Navigate h : navigateService.getAll()) {
			Map<String, String> tmp = new HashMap<>();
			tmp.put("href", h.getHref());
			tmp.put("title", h.getTitle());
			tmp.put("value", h.getValue());
			map.put(h.getId(), tmp);
		}
		return map;
	}
}
