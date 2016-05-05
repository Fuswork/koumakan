<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String title = "";
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
				<div style="padding:5px">
					<img src="static/image/about.png" style="height:48px">
					<span style="float:left;font-size:22px">搜索</span>
				</div>
				<div class="dividing-line"></div>
				<form class="input-group input-group-sm" style="margin-left:5%;width:80%" action="/search"
				      method="get">
					<input type="text" class="form-control" placeholder="${search_data}"
					       style="margin-left:5px"
					       name="search_data">
                    <span class="input-group-btn">
                      <button type="submit" style="margin-left:7px">搜索</button>
                      <button type="submit" style="margin-left:7px">只搜索标签</button>
                    </span>
				</form>

				<div class="dividing-line" style="margin-top:5px"></div>

				<% if ((Boolean) request.getAttribute("isnull")) { %>
				<div id="null_result" style="padding:10px">
					<span style="color:#5bc0de;font-weight:500">还未开始搜索</span>
				</div>
				<% } else { %>
				<div id="search_result" style="padding:5px">
                    <span style="font-weight:500">共搜索到<span style="color:#5bc0de;font-weight:700">15</span>个结果，当前显示
                        <span style="color:#5bc0de;font-weight:700">1</span>-<span
			                    style="color:#5bc0de;font-weight:700">5</span>个结果。搜索耗时
                        <span style="color:#5bc0de;font-weight:700">${time}</span>秒。
                    </span>

					<div style="float:right">
						<button class="btn  "><span class="glyphicon glyphicon-step-backward"></span>
						</button>

						<button class="btn  "><span class="glyphicon glyphicon-triangle-left"></span>
						</button>
						<button class="btn  ">2</button>
						<button class="btn  ">3</button>
						<button class="btn  "><span class="glyphicon glyphicon-triangle-right"></span>
						</button>
						<button class="btn  "><span class="glyphicon glyphicon-step-forward"></span>
						</button>
					</div>
				</div>
				<div id="content_div"></div>
				<div style="padding:5px">
                    <span style="font-weight:500">共搜索到<span style="color:#5bc0de;font-weight:700">15</span>个结果，当前显示
	                    <span style="color:#5bc0de;font-weight:700">1</span>-<span
			                    style="color:#5bc0de;font-weight:700">5</span>个结果。搜索耗时
                        <span style="color:#5bc0de;font-weight:700">${time}</span>秒。
                    </span>

					<div style="float:right">
						<button class="btn  "><span class="glyphicon glyphicon-step-backward"></span>
						</button>

						<button class="btn  "><span class="glyphicon glyphicon-triangle-left"></span>
						</button>
						<button class="btn  ">2</button>
						<button class="btn  ">3</button>
						<button class="btn  "><span class="glyphicon glyphicon-triangle-right"></span>
						</button>
						<button class="btn  "><span class="glyphicon glyphicon-step-forward"></span>
						</button>
					</div>
				</div>
				<% } %>
			</div>
		</div>


	</div>
</div>

<!-- 页尾 -->
<div style="height:20px"></div>
<%@include file="template/foot.jsp" %>

<script>
	var type = {}
	function label_click(data) {
		if ($(data).hasClass("label-notchoose")) {
			$(data).removeClass("label-notchoose");
		}
		else $(data).addClass("label-notchoose");
		$(data).blur();
	}

	function page_click(data) {

	}
</script>
</body>
</html>
