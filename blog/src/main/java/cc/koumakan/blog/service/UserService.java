package cc.koumakan.blog.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.User;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("unchecked & unused")
@Service("userService")
public class UserService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// 通过id获取数据
	public User getUserById(int user_id) throws Exception {
		return (User) dao.selectObject("UserMapper.selectById", user_id);
	}

	// 登陆查询
	public User login(String username) throws Exception {
		return (User) dao.selectObject("UserMapper.selectByName", username);
	}

	public void updateLogin(Date time, String ip, int id) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("lastlogin", time);
		map.put("lastip", ip);
		map.put("id", id);
		dao.update("UserMapper.updateLoginById", map);
	}
}
