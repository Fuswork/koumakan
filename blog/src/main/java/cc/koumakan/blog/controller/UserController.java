package cc.koumakan.blog.controller;

import cc.koumakan.blog.entity.User;
import cc.koumakan.blog.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.DigestMethod;
import java.net.HttpCookie;
import java.util.Arrays;
import java.util.Date;

@Controller
@SessionAttributes("user")
public class UserController {

	@Resource(name = "userService")
	private UserService userService;

	@RequestMapping("/login")
	public ModelAndView login() throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/login");
		return mv;
	}

	@RequestMapping("/login_login")
	@ResponseBody
	public String login_login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//登陆检查
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user = userService.login(user.getUsername());
		if (user == null)
			return "user not found";
		String s = request.getParameter("password");
		s = DigestUtils.md5DigestAsHex(s.getBytes());
		System.err.println("[DEBUG]:" + s);
		if (!s.equals(user.getPassword()))
			return "password error";
		// 登陆成功 写入session
		request.getSession().setAttribute("user", user);
		request.setAttribute("user", user);
		if (request.getParameter("remind me").equals("true")) {
			Cookie cookie = new Cookie("user_id", String.valueOf(user.getId()));
			cookie.setMaxAge(60 * 60 * 24 * 90);
			cookie.setSecure(true);
			response.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("user_id", String.valueOf(user.getId()));
			cookie.setMaxAge(60 * 15);
			cookie.setSecure(true);
			response.addCookie(cookie);
		}
		// 更新登录信息
		String ip;
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else
			ip = request.getHeader("x-forwarded-for");
		userService.updateLogin(new Date(), ip, user.getId());
		return "login success";
	}

	@RequestMapping("/regist")
	public ModelAndView regist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.sendError(403, "注册系统开发中");
		return null;
	}

	@RequestMapping("/person")
	public ModelAndView person(HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/person");
		Cookie cookie = new Cookie("user_id", String.valueOf(0));
		cookie.setMaxAge(0);
		cookie.setSecure(true);
		response.addCookie(cookie);
		return mv;
	}

}
