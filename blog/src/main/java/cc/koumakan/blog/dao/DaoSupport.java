package cc.koumakan.blog.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

@Repository("daoSupport")
public class DaoSupport implements DAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 保存对象
	 */
	public Object insert(String str, Object obj) throws Exception {
		return sqlSessionTemplate.insert(str, obj);
	}

	/**
	 * 修改对象
	 */
	public Object update(String str, Object obj) throws Exception {
		return sqlSessionTemplate.update(str, obj);
	}

	/**
	 * 删除对象
	 */
	public Object delete(String str, Object obj) throws Exception {
		return sqlSessionTemplate.delete(str, obj);
	}

	/**
	 * 查找对象
	 */
	public Object selectObject(String str, Object obj) throws Exception {
		return sqlSessionTemplate.selectOne(str, obj);
	}

	/**
	 * 查找对象
	 */
	public Object selectList(String str, Object obj) throws Exception {
		return sqlSessionTemplate.selectList(str, obj);
	}

	/**
	 * 查找对象
	 */
	public Object selectMap(String str, Object obj, String key, String value) throws Exception {
		return sqlSessionTemplate.selectMap(str, obj, key);
	}

}
