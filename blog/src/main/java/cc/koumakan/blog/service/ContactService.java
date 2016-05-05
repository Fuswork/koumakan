package cc.koumakan.blog.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.Contact;

@SuppressWarnings("unchecked & unused")
@Service("contactService")
public class ContactService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// 插入一条
	public void add(Contact c) throws Exception {
		dao.insert("ContactMapper.insertAuto", c);
	}

	// 设置为已读
	public void check(int id) throws Exception{
		dao.update("ContactMapper.updateById", id);
	}

	// 查看所有未读
	public void select(int id) throws Exception{
		dao.selectList("ContactMapper.selectAll", id);
	}
}
