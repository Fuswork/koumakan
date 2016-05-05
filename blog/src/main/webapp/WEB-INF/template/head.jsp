<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="cc.koumakan.blog.util.DateUtil" %>
<%@ page import="cc.koumakan.blog.entity.User" %>
<% User user = (User) request.getSession().getAttribute("user"); %>
<style>
	.head-face {
		border: 3px solid rgba(222, 222, 222, 0.6);
		border-radius: 50%;
		box-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
		margin-top: 40px;
		width: 100px;
	}

	.head-sface {
		float: right;
		margin-right: 5px;
		margin-top: 1px;
		border: 2px solid rgba(255, 255, 255, 0.6);
		border-radius: 50%;
		width: 35px;
	}

	.head-bg {
		background-size: 100% auto !important;
		background: #323232 url("/static/image/tg.jpg") no-repeat 0 0;
		text-align: center;
		min-height: 200px;
	}

	.head-name {
		color: white;
		font-weight: 500;
		font-size: 22px;
		text-shadow: 1px 1px 1px gray;
	}

	.head-btn {
		color: #ebebeb;
		font-size: 15px;
		padding: 10px 15px;
		float: left;
	}

	.head-btn:hover {
		color: #ebebeb;
		background-color: #454545;
	}

	.head-btn-focus, .head-btn:focus {
		color: #ebebeb;
		background-color: #2b3e50;
	}
</style>
<div class="container block head-bg" style="padding:0;height:255px">
	<div class="row">
		<img src="/static/image/face.jpg" class="head-face">
	</div>
	<div class="row" style="margin-top: -20px">
		<p class="head-name">威严满满蕾米莉亚</p>
	</div>
	<div class="row" style="background:#333;margin-top:20px;height:38px">
		<div style="float:left;margin-left:20px">
			<a id="head-btn-welcome" class="head-btn" href="/home">欢迎</a>
			<a id="head-btn-multimedia" class="head-btn" href="/multimedia">多媒体</a>
			<a id="head-btn-program" class="head-btn" href="/program">软件</a>
			<a id="head-btn-daily" class="head-btn" href="/daily">杂谈</a>
			<a id="head-btn-search" class="head-btn" href="/search">搜索</a>
		</div>
		<% if (user.getId() != 0) { %>
		<img class="clickable head-sface" onclick="location='/person'" src="/upload/<%=user.getId() %>.jpg"
		     alt="<%=user.getId() %>">
		<div style="float:right;text-align:right;padding:10px">
			<span><%=DateUtil.getPart() %>好,</span>
			<span style="color:blue"><%=user.getUsername() %></span>
			<span>。</span>
		</div>
		<% } else {%>
		<div style="float:right;text-align:right;padding:10px">
			<span><%=DateUtil.getPart() %>好,</span>
			<span style="color:blue">游客</span>
			<span>。 <a href="/login">登陆</a>/<a href="/regist">注册</a></span>
		</div>
		<% } %>
	</div>
</div>
<script>
	$("#head-btn-${current_page}").addClass("head-btn-focus")
</script>