<%@page import="cc.koumakan.blog.util.HtmlUtil" %>
<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

	Integer code = (Integer) request.getAttribute("javax.servlet.error.status_code");
	String message = String.valueOf(request.getAttribute("javax.servlet.error.message"));

	Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
	String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");
	String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- bootstrap 环境设置 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 页面信息设置 -->
	<title><%=code%> 错误</title>

	<!-- 载入js文件 -->
	<link href="/static/css/koumakan.css" rel="stylesheet"/>
	<script src="webjars/jquery/1.11.1/jquery.min.js"></script>
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
			<div class="block back-gray" style="padding:15px">
				<div class="row">
					<img src="/static/image/error.png" style="height:48px;float:left">
					<h2 style="float:left"><%=code %> 错误</h2>
				</div>

				<div class="dividing-line"></div>
				<br>

				<div>
					<span style="font-size:18px;font-weight:500">错误信息：</span><br>
					<span><%=HtmlUtil.htmlEncode(message) %></span>
				</div>
				<br>
				<button id="btn_more" onclick="show_more()">错误详情</button>

				<div id="more_view" style="display:none">
					<div>
						<span><strong>Request URI：</strong></span><br>
						<span style="word-break:break-all"><%=requestUri %></span>
					</div>
					<div>
						<span><strong>Servlet Name：</strong></span><br>
						<span style="word-break:break-all"><%=servletName %></span>
					</div>
					<div>
						<span><strong>Throwable：</strong></span><br>
						<span style="word-break:break-all"><%=HtmlUtil.htmlEncode(throwable + "") %></span>
					</div>
				</div>

			</div>
		</div>
	</div>

</div>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="./template/foot.jsp"/>

<script>
	function show_more() {
		$("#btn_more").css("display", "none");
		$("#more_view").css("display", "block");
	}
</script>
</body>
</html>
		