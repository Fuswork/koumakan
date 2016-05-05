package cc.koumakan.blog.service;

import cc.koumakan.blog.dao.DaoSupport;
import cc.koumakan.blog.entity.Article;
import cc.koumakan.blog.entity.Reply;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@SuppressWarnings("unchecked & unused")
@Service("replyService")
public class ReplyService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public void add(Reply reply) throws Exception{
		dao.insert("ReplyMapper.insertAuto", reply);
	}

	public List<Reply> get(Article article) throws Exception {
		return (List<Reply>)dao.selectList("ReplyMapper.selectByArticle", article);
	}
}
