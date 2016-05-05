<%@ page import="cc.koumakan.blog.entity.Article" %>
<%@ page import="cc.koumakan.blog.util.HtmlUtil" %>
<%@ page import="java.util.List" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	List<Article> articleList = (List<Article>) request.getAttribute("articleList");
	int[] reply_size = (int[]) request.getAttribute("reply_size");
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- bootstrap 环境设置 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 页面信息设置 -->
	<title>Welcome to Koumakan</title>

	<!-- 载入js文件 -->
	<link href="/static/css/koumakan.css" rel="stylesheet"/>
	<script src="webjars/jquery/1.11.1/jquery.min.js"></script>

	<style>
		.white-title {
			color: #ebebeb;
			font-size: 24px;
		}
	</style>
</head>

<body>
<!-- 顶部导航栏 -->
<jsp:include page="./template/topnav.jsp"/>
<div style="height:20px"></div>
<jsp:include page="./template/head.jsp"/>
<div style="height:20px"></div>
<!-- 主体内容 -->
<div class="container">
	<div id="mainview" class="row">
		<jsp:include page="./template/left.jsp"/>

		<!-- 主体内容 -->
		<div class="col-8" style="padding-left:0">
			<%
				boolean type = false;
				if (request.getAttribute("current_page").equals("welcome"))
					type = true;
				for (Article a : articleList) {
			%>
			<%=HtmlUtil.articleTemplate(a, reply_size[articleList.indexOf(a)], type)%>
			<% } %>
			<div id="load_view" class="block clickable back-gray" style="padding:5px;text-align:center"
			     onclick="load_more()">
				<span id="load_text">载入更多</span>
			</div>
		</div>

	</div>
</div>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="./template/foot.jsp"/>

<script>
	var home_lock = false;
	var load_more_times = 1;
	function load_more() {
		if (home_lock == true) return;
		home_lock = true;
		$("#load_text").text("载入中...");
		$("#load_view").css("cursor", "wait");
		var outtime = setTimeout(function () {
			if (home_lock) {
				$("#load_text").text("载入更多");
				$("#load_view").css("cursor", "pointer");
				alert("服务器娘不堪重负中（┭┮﹏┭┮）过会儿再试试吧!");
				home_lock = false;
			}
		}, 5000);
		var type = "${current_page}";
		if (type == "welcome")
			type = "multimedia program daily";

		$.ajax({
			url: "/load_more",
			type: "post",
			data: {
				"type": type,
				"times": load_more_times
			},
			success: function (data) {
				clearTimeout(outtime);
				home_lock = false;
				load_more_times++;
				if (data == "") {
					alert("没有更多了!");
					$("#load_text").text("没有更多了");
					$("#load_view").css("cursor", "not-allowed");
					home_lock = true;
					return;
				}
				else {
					$("#load_view").before(data);
				}
				$("#load_text").text("载入更多");
				$("#load_view").css("cursor", "pointer");
			}
		})
	}
</script>

</body>
</html>
