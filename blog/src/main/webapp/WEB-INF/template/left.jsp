<%@ page language="java" pageEncoding="UTF-8" %>
<style>
	.left-title {
		font-weight: 500;
		font-size: 14px;
		white-space: nowrap;
		overflow: hidden;
		text-align: center;
	}

	.left-block {
		background: #323232;
		width: 100%;
		padding: 10px;
	}

	.left-a {
		color: #ebebeb;
		font-size: 13px;
		font-weight: 100;
	}
</style>
<div id="show_left" class="col-2" style="overflow:hidden">
	<div class="block left-block">
		<div class="left-title">
			<img src="/static/image/left_1.png" style="height:32px;float:left">
			<div style="float:left;padding: 10px 5px">最新动态</div>
		</div>
		<div class="dividing-line" id="home"></div>
		<a class="left-a" href="/home">更多...</a>
	</div>
	<div style="height:8px"></div>
	<div class="block left-block">
		<div class="left-title">
			<img src="/static/image/left_2.png" style="height:32px;float:left">
			<div style="float:left;padding: 10px 5px">多媒体</div>
		</div>
		<div class="dividing-line" id="multimedia"></div>
		<a class="left-a" href="/multimedia">更多...</a>
	</div>
	<div style="height:8px"></div>
	<div class="block left-block">
		<div class="left-title">
			<img src="/static/image/left_3.png" style="height:32px;float:left">
			<div style="float:left;padding: 10px 5px">软件</div>
		</div>
		<div class="dividing-line" id="program"></div>
		<a class="left-a" href="/program">更多...</a>
	</div>
	<div style="height:8px"></div>
	<div class="block left-block">
		<div class="left-title">
			<img src="/static/image/left_4.png" style="height:32px;float:left">
			<div style="float:left;padding: 10px 5px">杂谈</div>
		</div>
		<div class="dividing-line" id="daily"></div>
		<a class="left-a" href="/daily">更多...</a>
	</div>
</div>

<script>
	$.ajax({
		type: "get",
		url: "left",
		success: function (data) {
			for (var i in data) {
				if (data.hasOwnProperty(i)) {
					$("#" + i.substring(0, i.length - 2)).after("<a class='left-a' id=" + i + "></a>");
					var a = $("#" + i);
					a.attr("href", data[i].href);
					a.attr("title", data[i].title);
					a.text(data[i].value);
					a.after("<br>");
				}
				else {
					alert("获取")
				}
			}
		}
	});
</script>