<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="cc.koumakan.blog.entity.User" %>
<%@ page import="cc.koumakan.blog.util.DateUtil" %>
<%
	User user = (User) request.getSession().getAttribute("user");
%>
<style>
	.navbar {
		position: fixed;
		z-index: 999;
		width: 100%;
	}

	.nav-btn {
		color: #ebebeb;
		font-size: 15px;
		padding: 10px 15px;
		float: left;
	}

	.nav-btn:hover {
		color: #ebebeb;
		background-color: #454545;
	}

	.nav-btn-focus, .nav-btn:focus {
		color: #ebebeb;
		background-color: #2b3e50;
	}
</style>
<nav id="topnav" class="navbar block back-gray" style="display:none;height:38px">
	<div class="row">
		<div class="col-6">
			<div style="float:left;margin-left:20px">
				<a id="nav-btn-welcome" class="nav-btn" href="/home">欢迎</a>
				<a id="nav-btn-multimedia" class="nav-btn" href="/multimedia">多媒体</a>
				<a id="nav-btn-program" class="nav-btn" href="/program">软件</a>
				<a id="nav-btn-daily" class="nav-btn" href="/daily">杂谈</a>
				<a id="nav-btn-search" class="nav-btn" href="/search">搜索</a>
			</div>
			<form style="margin-top:5px;max-width:300px;float:left" action="/search"
			      method="get">
				<input type="text" class="form-control" placeholder="Search for..." style="margin-left:5px"
				       name="search_data">
			</form>

		</div>

		<div class="col-4">
			<span style="float:left;padding: 10px 0" id="timer"></span>
			<% if (0 == user.getId()) { %>
			<a href="/login" style="float:right;padding: 10px 0">登陆</a>
			<span style="float:right;padding: 10px 0">/</span>
			<a href="/regist" style="float:right;padding: 10px 0">注册</a>
			<span style="padding: 10px 0;float:right">。</span>
			<span style="color:blue;padding: 10px 0;float:right">游客</span>
			<% } else { %>
			<img onclick="location='/person'" class="clickable head-sface" style="float:right"
			     src="/upload/<%=user.getId() %>.jpg"/>
			<span style="float:right;padding: 10px 0">。</span>
			<span onclick="location='/person'" class="clickable"
			      style="color:orange;float:right;padding: 10px 0"><%=user.getUsername() %></span>
			<% } %>
			<span style="float:right;padding: 10px 0"><%=DateUtil.getPart() %>好，</span>
		</div>
	</div>
</nav>
<%--<div id="top_button"--%>
     <%--style="position:fixed;right:10%;bottom:10%;z-index:999;text-align:center;display:none">--%>
	<%--<a href="javascript:sto_top()">○</a>--%>
<%--</div>--%>

<script>
	setTimeout(time, 0);
	$("#nav-btn-${current_page}").addClass("nav-btn-focus");
	function sto_top() {
		$("html,body").animate({
			scrollTop: "0px"
		}, 900);
	}
	function time() {
		var d = new Date();
		var m = d.getMonth() + 1;
		var h = d.getHours();
		var mn = d.getMinutes();
		var s = d.getSeconds();
		if (h <= 9) h = "0" + h;
		if (mn <= 9) mn = "0" + mn;
		if (s <= 9) s = "0" + s;
		var t = d.getFullYear() + "年" + m + "月" + d.getDate() + "日";
		t = t + " " + h + ":" + mn + ":" + s;
		$("#timer").text(t);
		setTimeout(time, 1000);
	}

	window.onscroll = function () {
		if ($("#mainview").offset().top > $(document).scrollTop() + 10) {
			$("#topnav").css("display", "none");
			$("#top_button").css("display", "none");
		}
		else {
			$("#topnav").css("display", "block");
			$("#top_button").css("display", "block");
		}
	}
</script>