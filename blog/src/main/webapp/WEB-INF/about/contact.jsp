<%@ page import="cc.koumakan.blog.entity.User" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- bootstrap 环境设置 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 页面信息设置 -->
	<title>${title}</title>

	<!-- 载入js文件 -->
	<link href="/static/css/koumakan.css" rel="stylesheet"/>
	<script src="webjars/jquery/1.11.1/jquery.min.js"></script>
</head>

<body>
<!-- 顶部导航栏 -->
<jsp:include page="../template/topnav.jsp"/>
<div style="height:20px"></div>
<jsp:include page="../template/head.jsp"/>
<div style="height:20px"></div>

<!-- 主体内容 -->
<div class="container">
	<div id="mainview" class="row row-divide">
		<jsp:include page="../template/left.jsp"/>

		<div class="col-8 block back-gray" style="padding:15px">
			<div class="row row-divide">
				<img src="/static/image/contact.png" style="height:48px;float:left">
				<h2 style="float:left">${title}</h2>
			</div>
			<div class="dividing-line"></div>
			<form class="form-horizontal" style="padding: 15px 15px 0;">
				<div class="row row-divide">
					<label class="col-2">主题：</label>
					<input class="col-6" name="title" type="text">
					<span class="col-2" style="color:red">*<span style="font-size:12px;color:#ebebeb">必填项</span></span>
				</div>
				<div class="row row-divide">
					<label class="col-2">内容：</label>
					<textarea class="col-6" name="content" style="resize:none;height:300px"></textarea>
					<span class="col-2" style="color:red">*<span style="font-size:12px;color:#ebebeb">必填项</span></span>
				</div>
				<div class="row row-divide">
					<div class="col-9 col-offset-1">
						<span style="color:#5bc0de">v</span>
						<span style="font-size:12px">请留下相关信息，以方便作者更好的做出反馈</span>
					</div>
				</div>
				<div class="row row-divide">
					<label class="col-2">昵称：</label>
					<input class="col-6" name="name" type="text" value="<%=user.getUsername()%>">

				</div>
				<div class="row row-divide">
					<label class="col-2">邮箱：</label>
					<input class="col-6" name="email" type="text" value="<%=user.getEmail() %>">

				</div>
				<div style="height: 6px"></div>
				<div class="row row-divide">
					<div class="col-4 col-offset-3" style="text-align: center">
						<button id="submit_button" class="btn" type="button" onclick="my_submit()" style="margin:auto">
							<span id="submit_text">提交</span>
						</button>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>

<script>
	var lock = false;
	function my_submit() {
		if (lock) return;
		lock = true;
		$("#submit_text").text("提交中...");
		$("#submit_button").addClass("disabled");

		var outtime = setTimeout(function () {
			if (lock) {
				$("#submit_text").text("提交");
				$("#submit_button").removeClass("disabled");
				alert("服务器娘不堪重负中（┭┮﹏┭┮）过会儿再试试吧!");
				lock = false;
			}
		}, 5000);
		$.ajax({
			data: {
				"name": $("input[name='name']").val(),
				"email": $("input[name='email']").val(),
				"title": $("input[name='title']").val(),
				"content": $("textarea[name='content']").val()
			},
			type: "post",
			url: "/contact_contact",
			success: function (data) {
				if (data == "success") {
					$("#submit_text").text("已提交");
					clearTimeout(outtime);
					alert("提交成功!");
				}
				else if (data == "null") {
					if (lock) {
						$("#submit_text").text("提交");
						$("#submit_button").removeClass("disabled");
						lock = false;
					}
					alert("标题和内容不能为空!");
					clearTimeout(outtime);
				}
			}
		});
	}
</script>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="../template/foot.jsp"/>
</body>
</html>