package cc.koumakan.blog.dao;

@SuppressWarnings("unused")
public interface DAO {

	/**
	 * 保存对象
	 */
	Object insert(String str, Object obj) throws Exception;

	/**
	 * 修改对象
	 */
	Object update(String str, Object obj) throws Exception;

	/**
	 * 删除对象
	 */
	Object delete(String str, Object obj) throws Exception;

	/**
	 * 查找对象
	 */
	Object selectObject(String str, Object obj) throws Exception;

	/**
	 * 查找对象封装成List
	 */
	Object selectList(String str, Object obj) throws Exception;

	/**
	 * 查找对象封装成Map
	 */
	Object selectMap(String sql, Object obj, String key, String value) throws Exception;

}
