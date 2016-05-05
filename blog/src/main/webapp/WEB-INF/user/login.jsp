<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- bootstrap 环境设置 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 页面信息设置 -->
	<title>用户登录</title>

	<!-- 载入js文件 -->
	<link href="/static/css/koumakan.css" rel="stylesheet"/>
	<script src="webjars/jquery/1.11.1/jquery.min.js"></script>

	<style>
		label {
			padding-top: 5px;
			padding-bottom: 5px;
		}
	</style>
</head>

<body>
<!-- 顶部导航栏 -->
<jsp:include page="../template/topnav.jsp"/>
<div style="height:20px"></div>
<jsp:include page="../template/head.jsp"/>
<div style="height:20px"></div>
<!-- 主体内容 -->
<div class="container">
	<div id="mainview" class="row">
		<jsp:include page="../template/left.jsp"/>
		<!-- 主体内容 -->
		<div class="col-8" style="padding-left:0">
			<div class="block back-gray" style="padding:15px">
				<div class="row">
					<img src="/static/image/contact.png" style="height:48px;float:left">
					<h2 style="float:left">用户登录</h2>
				</div>
				<div class="dividing-line"></div>
				<%if ((request.getParameter("type") != null) && (request.getParameter("type").equals("refuse"))) {%>
				<div style="padding-top:10px;padding-left:10px">
					<span style="color:#d9534f">请先登录!</span>
				</div>
				<%} %>
				<form style="padding: 15px 15px 0;">
					<div class="row row-divide">
						<label class="col-2">用户名：</label>
						<input class="col-4" id="input_username" name="username" type="text">
                        <span id="error_nouser" class="col-2" style="display:none;color:#d9534f">
                            *未找到用户!
                        </span>
					</div>
					<div class="row row-divide">
						<label class="col-2">密码：</label>
						<input class="col-4" id="input_password" name="password" type="password">
                        <span id="error_wrongpass" class="col-2" style="display:none;color:#d9534f;">
                            *密码错误!
                        </span>
					</div>
					<div class="row row-divide">
						<label class="col-4 col-offset-2" style="padding-left: 0 !important">
							<input id="checkbox" type="checkbox" name="remind"> 记住我
						</label>
					</div>
					<div class="row row-divide">
						<div class="col-2 col-offset-2">
							<button id="login_button" class="btn" type="button" onclick="login()"
							        style="width:100%">
								登陆
							</button>
						</div>
						<div class="col-2">
							<button id="regist_button" class="btn disabled" type="button" onclick="javascript:void(0);"
							        style="width:100%">
								注册
							</button>
						</div>
					</div>
				</form>

			</div>
		</div>

	</div>
</div>

<script>
	var lock = false;
	function login() {
		if (lock) return;
		lock = true;
		$("#login_button").text("登陆中...");
		$("#login_button").addClass("disabled");
		$("#error_nouser").css("display", "none");
		$("#error_wrongpass").css("display", "none");
		outtime = setTimeout(function () {
			if (lock) {
				$("#login_button").text("登陆");
				$("#login_button").removeClass("disabled");
				alert("服务器娘不堪重负中（┭┮﹏┭┮）过会儿再试试吧!");
				lock = false;
			}
		}, 5000);
		$.ajax({
			data: {
				"username": $("input[name='username']").val(),
				"password": $("input[name='password']").val(),
				"remind me": document.getElementById("checkbox").checked
			},
			type: "post",
			url: "/login_login",
			success: function (data) {
				clearTimeout(outtime);
				if (data == "login success") {
					if (<%=(request.getParameter("type") != null) && (request.getParameter("type").equals("refuse"))%>)
						window.location.href = "/load";
					else  self.location = document.referrer;
				}
				else {
					if (lock) {
						$("#login_button").text("登陆");
						$("#login_button").removeClass("disabled");
						lock = false;
					}
					if (data == "user not found")$("#error_nouser").css("display", "block");
					if (data == "password error")$("#error_wrongpass").css("display", "block");
				}
			}
		});

	}
</script>
<!-- 页尾 -->
<div style="height:20px"></div>
<%@include file="../template/foot.jsp" %>
</body>
</html>
