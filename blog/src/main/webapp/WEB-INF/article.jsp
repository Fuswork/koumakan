<%@ page language="java" import="cc.koumakan.blog.entity.Article" pageEncoding="UTF-8" %>
<%@ page import="cc.koumakan.blog.entity.Reply" %>
<%@ page import="cc.koumakan.blog.util.DateUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="cc.koumakan.blog.entity.User" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	Article article = (Article) request.getAttribute("article");

	//处理标签
	StringBuilder lable = new StringBuilder();
	for (String s : article.getLabel().split(" ")) {
		lable.append("<a href='/search?label=" + s + "' class='gray'>" + s + "</a>&nbsp;");
	}

	Article pre = (Article) request.getAttribute("pre_article");
	Article next = (Article) request.getAttribute("next_article");
	List<Reply> replies = (List<Reply>) request.getAttribute("replies");

	User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- bootstrap 环境设置 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 页面信息设置 -->
	<title><%=article.getTitle()%></title>

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
				<div style="text-align:center">
					<span style="font-size:26px;font-weight:500">${article.title}</span>
					<br>
              <span style="color:#aaaaaa;font-size:12px">              
              <span>分类:<a href="/<%=article.getType()%>" class="gray"><%=article.getType()%></a></span>&emsp;
	              <span>标签:<%=lable.toString()%></span>&nbsp;&nbsp;
              <span>@:<%=DateUtil.FormatChineseTime(article.getDate())%></span></span>
				</div>
				<div class="dividing-line"></div>
				<p style="padding:0 10px;margin:10px 0">${article.content}</p>

				<div class="dividing-line"></div>
				<div style="text-align:center;font-size:12px;color:#aaaaaa;margin-top:3px">
					<span>上一篇：</span>
					<% if (pre == null) { %>
					<span>没有了</span>
					<% } else { %>
					<a href="/article/<%=pre.getId()%>" class="gray">
						<%=pre.getTitle()%>
					</a>
					<% } %>
					&emsp;&emsp;&emsp;
					<span>下一篇：</span>
					<% if (next == null) { %>
					<span>没有了</span>
					<% } else { %>
					<a href="/article/<%=next.getId()%>" class="gray">
						<%=next.getTitle()%>
					</a>
					<% } %>
				</div>
			</div>
			<div style="height:10px"></div>
			<div class="block back-gray" style="padding:10px">
				<div style="margin:0 5px">
                <span>
                    评论列表
                </span>
				</div>
				<% if (replies.size() == 0) { %>
				<div class="back-deep-gray" style="margin:5px 0;height:60px;text-align:center;padding:20px">
					<span>暂时还未有评论</span>
				</div>
				<%
					}
					int floor = 0;
					for (Reply r : replies) {
						floor++;
						int picture = r.getUserid();
				%>
				<div class="back-deep-gray" style="margin:5px 0">
					<div style="overflow:hidden;zoom:1;padding:5px">
						<div style="float:left">
							<div style="padding:5px;float:left">
								<img src="upload/<%=picture%>.jpg"
								     style="width:40px;height:40px;border:solid 2px #323232">
							</div>
							<div style="padding:5px 0;float:left">
								<span style="font-size:14px"><%=request.getAttribute("user_" + r.getUserid()) %></span>&emsp;
								<span style="color:#aaaaaa;font-size:12px"><%=DateUtil.FormatChineseTime(r.getDate()) %></span>
							</div>
						</div>
						<div style="float:right">
							<span style="color:#aaaaaa;font-size:12px">#<%=floor %></span>
						</div>
					</div>
					<div style="margin-left:40px;margin-top:-5px">
						<span style="display:block"><%=r.getContent() %></span>
					</div>
					<div style="height:6px"></div>
				</div>
				<% } %>
			</div>
			<div style="height:10px"></div>
			<div class="block back-gray" style="padding:10px">
                <span style="margin:0 5px">
                    发表评论
                </span>
				<form style="padding:5px 15px">
					<div class="row row-divide">
						<label class="col-2" style="text-align: right">昵称:</label>
						<input class="col-6" type="text" disabled="disabled" value="<%=user.getUsername()%>">
					</div>
					<div class="row row-divide">
						<label class="col-2" style="text-align: right">内容:</label>
						<textarea class="col-6" style="resize:none;height:150px" name="content"></textarea>
					</div>
					<div class="row row-divide">
						<div class="col-4 col-offset-3" style="text-align: center">
							<button id="submit_button" class="btn" type="button" onclick="submit_reply()"
							        style="width:60%">
								<span id="submit_text">发表</span>
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
	function submit_reply() {

		if (lock) return;
		if ($("textarea[name='content']").val() == "") {
			alert("内容不能为空！");
			return;
		}
		lock = true;

		$("#submit_text").text("发表中...");
		$("#submit_button").addClass("disabled");

		var outtime = setTimeout(function () {
			if (lock) {
				$("#submit_text").text("发表");
				$("#submit_button").removeClass("disabled");
				alert("服务器娘不堪重负中（┭┮﹏┭┮）过会儿再试试吧!");
				lock = false;
			}
		}, 5000);
		$.ajax({
			data: {
				"article_id": "<%=article.getId()%>",
				"content": $("textarea[name='content']").val()
			},
			type: "post",
			url: "/reply",
			success: function (data) {
				if (data == "success") {
					$("#submit_text").text("已提交");
					clearTimeout(outtime);
					alert("提交成功!");
					location.reload();
				}
				else if (data == "failed") {
					if (lock) {
						$("#submit_text").text("发表");
						$("#submit_button").removeClass("disabled");
						alert("提交失败！");
						lock = false;
					}
					clearTimeout(outtime);
				}
			}
		});
	}
</script>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="./template/foot.jsp"/>
</body>
</html>
