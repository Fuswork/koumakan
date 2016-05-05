package cc.koumakan.blog.service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.Navigate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@SuppressWarnings("unchecked & unused")
@Service("navigateService")
public class NavigateService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;


	public List<Navigate> getAll() throws Exception {
		return (List<Navigate>) dao.selectList("NavigateMapper.selectAll", null);
	}

}
