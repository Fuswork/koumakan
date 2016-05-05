package cc.koumakan.blog.interceptor;


import cc.koumakan.blog.entity.User;
import cc.koumakan.blog.service.UserService;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

public class MyInterceptor implements HandlerInterceptor {
	@Resource(name = "userService")
	private UserService userService;

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {


	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {

	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		if (arg0.getSession().getAttribute("user") == null) {
			// 从Cookie中查询
			Cookie[] cookies = arg0.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("user_id")) {
						if (cookie.getMaxAge() == 0) return true;
						User user = userService.getUserById(Integer.parseInt(cookie.getValue()));
						arg0.getSession().setAttribute("user", user);
						// 更新登录信息
						String ip;
						if (arg0.getHeader("x-forwarded-for") == null) {
							ip = arg0.getRemoteAddr();
						} else
							ip = arg0.getHeader("x-forwarded-for");
						userService.updateLogin(new Date(), ip, user.getId());
						return true;
					}
				}
			}
			arg0.getSession().setAttribute("user", userService.getUserById(0));
		}
		return true;
	}
}
