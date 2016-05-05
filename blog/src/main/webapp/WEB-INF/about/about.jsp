<%@page language="java" pageEncoding="UTF-8" %>
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
	<div id="mainview" class="row">
		<jsp:include page="../template/left.jsp"/>

		<div class="col-8" style="padding-left:0">
			<div class="block back-gray" style="padding:15px">
				<div class="row">
					<img src="/static/image/about.png" style="height:48px;float:left">
					<h2 style="float:left">${title}</h2>
				</div>
				<div class="dividing-line"></div>
				<div style="padding:5px">
					${content}
				</div>
				<div class="dividing-line"></div>
				<div style="text-align:center">
					<span style="font-size:12px;color:#aaaaaa">${time}</span>
					<span style="font-size:12px;color:#aaaaaa">&emsp;By: ${author}</span>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="../template/foot.jsp"/>
</body>
</html>