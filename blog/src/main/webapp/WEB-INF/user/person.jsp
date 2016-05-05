<%@ page language="java" pageEncoding="UTF-8" %>
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
	<title>个人中心</title>

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
	<div id="mainview" class="row">
		<jsp:include page="../template/left.jsp"/>

		<!-- 主体内容 -->
		<div class="col-8" style="padding-left:0">
			<div class="block back-gray" style="padding:15px">
				<img src="/static/image/tg.jpg" style="width:100%">
			</div>
		</div>

	</div>
</div>

<!-- 页尾 -->
<div style="height:20px"></div>
<%@include file="../template/foot.jsp" %>

</body>
</html>
