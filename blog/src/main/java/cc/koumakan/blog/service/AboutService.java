package cc.koumakan.blog.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.About;

@SuppressWarnings("unchecked & unused")
@Service("aboutService")
public class AboutService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public About findByTitle(String title) throws Exception {
		return (About) dao.selectObject("AboutMapper.selectByTitle", title);
	}

}
