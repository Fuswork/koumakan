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
	<title>服务器状态</title>

	<!-- 载入js文件 -->
	<link href="/static/css/koumakan.css" rel="stylesheet"/>
	<script src="webjars/jquery/1.11.1/jquery.min.js"></script>

	<style>
		table {
			font-size: 14px;
		}

		.pull-left {
			float: left;
			margin-top: 5px;
		}

		.color-box {
			padding: 3px;
			text-align: center;

		}

		.color-show {
			height: 16px;
			width: 16px;
			border: #232323 solid 2px;
			margin: auto;
		}

		.load-span {
			font-size: 12px;
			float: left;
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

		<div class="col-8 block back-gray" style="padding:15px">
			<div class="row">
				<img src="/static/image/contact.png" style="height:48px;float:left">
				<h2 style="float:left">服务器状态</h2>
				<button id="refresh_button" class="btn" style="margin:15px"
				        onclick="load_refresh()">
					<span id="refresh_text">刷新</span>
				</button>
			</div>

			<div class="dividing-line"></div>

			<!-- CPU -->
			<div class="row">
				<span class="pull-left">CPU状态:</span>

				<div class="pull-left color-box" style="margin-left:15%">
					<div class="color-show pull-left" style="background:#f0ad4e">&emsp;</div>
					<span class="load-span">用户使用</span>
				</div>
				<div class="pull-left color-box">
					<div class="color-show pull-left" style="background:#5bc0de">&emsp;</div>
					<span class="load-span">其他使用</span>
				</div>
				<div class="pull-left color-box">
					<div class="color-show pull-left" style="background:#d9534f">&emsp;</div>
					<span class="load-span">等待及错误</span>
				</div>
				<div class="pull-left color-box">
					<div class="color-show pull-left" style="background:#5cb85c">&emsp;</div>
					<span class="load-span">空闲</span>
				</div>
			</div>
			<table id="cpu_table" class="row">
				<tr id="cpu_no" style="display:table-row">
					<td style="width:80px"></td>
					<td>
						<h5>未检测到CPU！</h5>
					</td>
					<td style="width:160px"></td>
				</tr>
			</table>

			<div class="dividing-line"></div>

			<!-- 内存 -->
			<div class="row">
				<span class="pull-left">内存状态:</span>

				<div class="pull-left color-box" style="margin-left:15%">
					<div class="color-show pull-left" style="background:#f0ad4e">&emsp;</div>
					<span class="load-span">使用中</span>
				</div>
				<div class="pull-left color-box">
					<div class="color-show pull-left" style="background:#5cb85c">&emsp;</div>
					<span class="load-span">空闲</span>
				</div>
			</div>
			<table class="row">
				<tr>
					<td style="width:80px"><span>内存区</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
								<span id="m_use_bar"></span>
							</div>
							<div class="progress-bar progress-bar-success" aria-valuemin="0" aria-valuemax="100"
							     style="width: 0%">
								<span id="m_free_bar"></span>
							</div>
						</div>
					</td>
					<td style="width:160px"><span id="m_use">载入中...</span> / <span id="m_av">载入中...</span></td>
				</tr>

				<tr>
					<td><span>交换区</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
								<span id="s_use_bar"></span>
							</div>
							<div class="progress-bar progress-bar-success" aria-valuemin="0" aria-valuemax="100"
							     style="width: 0%">
								<span id="s_free_bar"></span>
							</div>
						</div>
					</td>
					<td><span id="s_use">载入中...</span> / <span id="s_av">载入中...</span></td>
				</tr>

			</table>

			<div class="dividing-line"></div>

			<!-- jvm运行环境 -->
			<div class="row">
				<span class="pull-left">服务器环境:</span>
			</div>
			<table class="row">
				<tr>
					<td style="width:80px"><span>jvm内存使用</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
								<span id="jvm_use_bar"></span>
							</div>
							<div class="progress-bar progress-bar-success" aria-valuemin="0" aria-valuemax="100"
							     style="width: 0%">
								<span id="jvm_free_bar"></span>
							</div>
						</div>
					</td>
					<td style="width:160px"><span id="jvm_use">载入中...</span> / <span id="jvm_av">载入中...</span>
					</td>
				</tr>
				<tr>
					<td style="width:80px"><span>jvm处理器个数</span></td>
					<td><span id="jvm_cpu">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_5" style="display:none">
					<td style="width:80px"><span>操作系统名称</span></td>
					<td><span id="system_name">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_6" style="display:none">
					<td style="width:80px"><span>处理器架构</span></td>
					<td><span id="system_type">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_7" style="display:none">
					<td style="width:80px"><span>java版本</span></td>
					<td><span id="java_version">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_8" style="display:none">
					<td style="width:80px"><span>java供应商</span></td>
					<td><span id="java_vendor">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_9" style="display:none">
					<td style="width:80px"><span>中间件版本</span></td>
					<td><span id="java_server_info"><%= application.getServerInfo() %></span>
					</td>
				</tr>
				<tr id="load_more_1" style="display:none">
					<td style="width:80px"><span>服务器名称</span></td>
					<td><span id="computer_name">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_2" style="display:none">
					<td style="width:80px"><span>服务器账户</span></td>
					<td><span id="computer_username">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_3" style="display:none">
					<td style="width:80px"><span>服务器IP</span></td>
					<td><span id="net_ip">载入中...</span>
					</td>
				</tr>
				<tr id="load_more_4" style="display:none">
					<td style="width:80px"><span>本地主机名</span></td>
					<td><span id="net_host">载入中...</span>
					</td>
				</tr>
			</table>
			<div id="load_btn" style="padding:10px">
				<button class="btn" onclick="load_show_more()">更多参数</button>
			</div>
		</div>
	</div>
</div>

</div>
<!-- 页尾 -->
<div style="height:20px"></div>
<jsp:include page="../template/foot.jsp"/>

<script>
	var lock = false;
	function load_show_more() {
		$("#load_btn").css("display", "none");
		$("#load_more_1").css("display", "table-row");
		$("#load_more_2").css("display", "table-row");
		$("#load_more_3").css("display", "table-row");
		$("#load_more_4").css("display", "table-row");
		$("#load_more_5").css("display", "table-row");
		$("#load_more_6").css("display", "table-row");
		$("#load_more_7").css("display", "table-row");
		$("#load_more_8").css("display", "table-row");
		$("#load_more_9").css("display", "table-row");
	}
	window.onload = load_refresh();

	function load_refresh() {
		$("#refresh_button").blur();
		if (lock) return;
		lock = true;
		$("#refresh_text").text("载入中...");
		$("#refresh_button").addClass("disabled");

		$(".progress-bar").css("width", "0%");

		outtime = setTimeout(function () {
			if (lock) {
				$("#refresh_text").text("刷新");
				$("#refresh_button").removeClass("disabled");
				alert("服务器娘不堪重负中（┭┮﹏┭┮）过会儿再试试吧!");
				lock = false;
			}
		}, 5000);

		$.ajax({
			type: "post",
			url: "/load_data",
			success: function (data) {
				//jvm
				for (var i in data.jvm) {
					$("#" + i).text(data.jvm[i]);
				}
				var free = parseInt(data.jvm["jvm_free"]);
				var av = parseInt(data.jvm["jvm_av"]);
				var use = av - free;
				var free_bar = parseInt(100 * free / av + 1) + "%";
				var use_bar = parseInt(100 * use / av) + "%";

				$("#jvm_av").text((av / 1024 / 1024).toFixed(2) + "  Mb");
				$("#jvm_use").text((use / 1024 / 1024).toFixed(2));
				$("#jvm_free_bar").text(free_bar);
				$("#jvm_free_bar").parent().css("width", free_bar);
				$("#jvm_use_bar").text(use_bar);
				$("#jvm_use_bar").parent().css("width", use_bar);

				//memory_m
				free = parseInt(data.memory["m_free"]);
				use = parseInt(data.memory["m_used"]);
				av = parseInt(data.memory["m_av"]);
				free_bar = parseInt(100 * free / av + 1) + "%";
				use_bar = parseInt(100 - parseFloat(free_bar)) + "%";

				$("#m_use").text((use / 1024 / 1024).toFixed(2));
				$("#m_av").text((av / 1024 / 1024).toFixed(2) + "  Mb");

				$("#m_free_bar").text(free_bar);
				$("#m_free_bar").parent().css("width", free_bar);
				$("#m_use_bar").text(use_bar);
				$("#m_use_bar").parent().css("width", use_bar);

				//memory_s
				free = parseInt(data.memory["s_free"]);
				use = parseInt(data.memory["s_used"]);
				av = parseInt(data.memory["s_av"]);
				free_bar = parseInt(100 * free / av) + "%";
				use_bar = parseInt(100 - parseFloat(free_bar)) + "%";

				$("#s_use").text((use / 1024 / 1024).toFixed(2));
				$("#s_av").text((av / 1024 / 1024).toFixed(2) + "  Mb");

				$("#s_free_bar").text(free_bar);
				$("#s_free_bar").parent().css("width", free_bar);
				$("#s_use_bar").text(use_bar);
				$("#s_use_bar").parent().css("width", use_bar);

				//cpu
				var info;
				var user, other, wait, idle;
				for (var cpu in data.cpu) {
					if ($("#" + cpu).length <= 0) {
						var c1 = "<td style='width:80px'><span>" + cpu + "</span></td>";
						var c2 = "<td>                                                                                       \
                      <div class='progress'>                                                                            \
                      <div class='progress-bar progress-bar-warning' style='width:0%'>   \
                        <span id='" + cpu + "_use_bar'></span>                                                          \
                      </div>                                                                                      \
                      <div class='progress-bar progress-bar-info' style='width:0%'>                             \
                        <span id='" + cpu + "_wait_bar'></span>                                                         \
                      </div>                            	                                                      \
                      <div class='progress-bar progress-bar-danger' style='width:0%'>                           \
                        <span id='" + cpu + "_error_bar'></span>                                                        \
                      </div>                                                                                      \
                      <div class='progress-bar progress-bar-success' style='width:0%'>                          \
                        <span id='" + cpu + "_idle_bar'></span>                                                         \
                      </div>                                                                                      \
                      </div>                                                                                            \
                      </td>";
						var c3 = "<td style='width:160px'><span id=" + cpu + "_info>" + cpu + "</span></td>";

						var place = 0;
						var tablerow = $("#cpu_no");
						while (cpu.charAt(4) > tablerow.next().attr("no")) {
							tablerow = tablerow.next();
							place++;
						}
						$("#cpu_table tr:eq(" + place + ")").after("<tr id='" + cpu + "' no='" + cpu.charAt(4) + "'>" + c1 + c2 + c3 + "</tr>");
					}


					info = data.cpu[cpu].Vendor + " " + data.cpu[cpu].Model + " " + data.cpu[cpu].Mhz + "MHZ"
					$("#" + cpu).css("display", "table-row");
					$("#" + cpu + "_info").text(info);

					user = data.cpu[cpu].User;
					other = (parseFloat(data.cpu[cpu].Combined) - parseFloat(user)).toFixed(1) + "%";
					wait = (parseFloat(data.cpu[cpu].Nice) + parseFloat(data.cpu[cpu].Wait)).toFixed(1) + "%";
					idle = (parseFloat(data.cpu[cpu].Idle) - parseFloat(wait)).toFixed(1) + "%";
					$("#" + cpu + "_use_bar").text(user);
					$("#" + cpu + "_use_bar").parent().css("width", user);
					$("#" + cpu + "_wait_bar").text(other);
					$("#" + cpu + "_wait_bar").parent().css("width", other);
					$("#" + cpu + "_error_bar").text(wait);
					$("#" + cpu + "_error_bar").parent().css("width", wait);
					$("#" + cpu + "_idle_bar").text(idle);
					$("#" + cpu + "_idle_bar").parent().css("width", idle);
				}
				$("#cpu_no").css("display", "none");


				$("#refresh_text").text("刷新");
				$("#refresh_button").removeClass("disabled");

				lock = false;
				clearTimeout(outtime);
			}
		});
	}

	function sleep(numberMillis) {
		var now = new Date();
		var exitTime = now.getTime() + numberMillis;
		while (true) {
			now = new Date();
			if (now.getTime() > exitTime)    return;
		}
	}
</script>
</body>
</html>