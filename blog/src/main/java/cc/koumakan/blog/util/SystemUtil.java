package cc.koumakan.blog.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.hyperic.sigar.*;

@SuppressWarnings("unchecked & unused")
public class SystemUtil {
	// CPU
	public static Map<String, Object> cpu() throws SigarException {
		Sigar sigar = new Sigar();
		Map<String, Object> map = new HashMap<>();
		Map<String, String> tmp;

		CpuInfo infos[] = sigar.getCpuInfoList();
		CpuPerc cpuList[] = sigar.getCpuPercList();
		for (int i = 0; i < infos.length; i++) {// 不管是单块CPU还是多CPU都适用
			tmp = new HashMap<>();

			CpuInfo info = infos[i];
			tmp.put("Mhz", info.getMhz() + "");// CPU的总量MHz
			tmp.put("Vendor", info.getVendor());// 获得CPU的卖主，如：Intel
			tmp.put("Model", info.getModel());// 获得CPU的类别，如：Celeron
			tmp.put("CacheSize", info.getCacheSize() + "");// 缓冲存储器数量

			CpuPerc cpu = cpuList[i];
			tmp.put("User", CpuPerc.format(cpu.getUser()));// 用户使用率
			tmp.put("Wait", CpuPerc.format(cpu.getWait()));// 当前等待率
			tmp.put("Nice", CpuPerc.format(cpu.getNice()));// 错误率
			tmp.put("Idle", CpuPerc.format(cpu.getIdle()));// 当前空闲率
			tmp.put("Combined", CpuPerc.format(cpu.getCombined()));// 总的使用率

			map.put("cpu_" + i, tmp);
		}
		return map;
	}

	// memory
	public static Map<String, Long> memory() throws SigarException {
		Sigar sigar = new Sigar();
		Map<String, Long> map = new HashMap<>();

		Mem mem = sigar.getMem();
		map.put("m_av", mem.getTotal());// 内存总量
		map.put("m_used", mem.getUsed());// 当前内存使用量
		map.put("m_free", mem.getFree());// 当前内存剩余量

		Swap swap = sigar.getSwap();
		map.put("s_av", swap.getTotal());// 交换区总量
		map.put("s_used", swap.getUsed());// 当前交换区使用量
		map.put("s_free", swap.getFree());// 当前交换区剩余量
		return map;
	}

	// jvm
	public static Map<String, String> jvm() throws UnknownHostException {
		Map<String, String> map = new HashMap<>();

		Runtime r = Runtime.getRuntime();
		Properties props = System.getProperties();
		InetAddress addr = InetAddress.getLocalHost();
		Map<String, String> map2 = System.getenv();


		String system_name = props.getProperty("os.name");
		// if (system_name.equals("Windows 8"))
		// system_name = "Windows 10";
		// else if (system_name.equals("Linux"))
		// system_name = "CentOS 7 (Linux RedHat)";
		map.put("system_name", props.getProperty("os.name"));// 操作系统名称
		map.put("system_type", props.getProperty("os.arch"));// 操作系统类型
		map.put("computer_name", map2.get("COMPUTERNAME"));// 计算机名称
		map.put("computer_username", map2.get("USERNAME"));// 用户名
		map.put("net_ip", addr.getHostAddress());// ip地址
		map.put("net_host", addr.getHostName());// 本地主机名

		map.put("jvm_free", r.freeMemory() + "");// jvm剩余内存
		map.put("jvm_av", r.totalMemory() + "");// jvm总内存x
		map.put("jvm_cpu", r.availableProcessors() + "");// jvm处理器个数

		map.put("java_version", props.getProperty("java.version"));// java版本
		map.put("java_vendor", props.getProperty("java.vendor"));// java供应商

		return map;
	}

}