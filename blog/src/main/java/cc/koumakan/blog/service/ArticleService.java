package cc.koumakan.blog.service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.Article;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@SuppressWarnings("unchecked & unused")
@Service("articleService")
public class ArticleService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// 分类页面第一次载入
	public List<Article> getByType(List<String> type, int start, int offset) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("start", start);
		map.put("offset", offset);
		return (List<Article>) dao.selectList("ArticleMapper.selectByList", map);
	}

	// 按类型 载入更多
	public List<Article> getByType(List<String> type, int start, int offset, Date old, Date n) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("old", old);
		map.put("new", n);
		map.put("start", start);
		map.put("offset", offset);
		return (List<Article>) dao.selectList("ArticleMapper.selectByList", map);
	}

	// 文章页面调用 返回当前完整文章和上下文名字
	public Article getById(String id) throws Exception {
		Article a = (Article) dao.selectObject("ArticleMapper.selectById", id);
		if (a == null)
			return null;
		return a;
	}

	// 上一篇
	public Article getPre(String id) throws Exception {
		id = String.valueOf(Integer.parseInt(id) - 1);
		return (Article) dao.selectObject("ArticleMapper.selectById", id);
	}

	// 下一篇
	public Article getNext(String id) throws Exception {
		id = String.valueOf(Integer.parseInt(id) + 1);
		return (Article) dao.selectObject("ArticleMapper.selectById", id);
	}
}
