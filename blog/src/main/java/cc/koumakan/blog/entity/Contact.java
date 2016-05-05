package cc.koumakan.blog.entity;

import java.util.Date;

@SuppressWarnings("unused")
public class Contact {
	int id;
	String title;
	String content;
	String name;
	String email;
	String ip;
	Date date;
	Boolean isread;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Boolean getIsread() {
		return isread;
	}

	public void setIsread(Boolean isread) {
		this.isread = isread;
	}
}
