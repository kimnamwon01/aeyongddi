package springweb.a01_start;
// springweb.a01_start.A04_Controller
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class A04_Controller {
	// 요청값/모델연습
	// http://localhost:7080/springweb/reqexp01.do
	@RequestMapping("reqexp01.do")
	public String reqexp01() {
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
	// http://localhost:7080/springweb/reqexp02.do?name=홍길동
	@RequestMapping("reqexp02.do")
	public String reqexp02(@RequestParam("name") String name) {
		System.out.println("name:"+name);
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
	// http://localhost:7080/springweb/reqexp03.do?age=25
	@RequestMapping("reqexp03.do")
	public String reqexp03(@RequestParam("age") int age) {
		System.out.println("age:"+age);
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
	@RequestMapping("gogo01.do")
	public String gogo01(@RequestParam("id") String id) {
		System.out.println("id:"+id);
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
	@RequestMapping("byebye02.do")
	public String byebye02(@RequestParam("cnt") int cnt) {
		System.out.println("cnt:"+cnt);
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
	@RequestMapping("ohweekend03.do")
	public String ohweekend03(@RequestParam("feel") String feel) {
		System.out.println("feel:"+feel);
		return "WEB-INF\\views\\a01_form\\a02_requestShow.jsp";
	}
}
//ex1) http://localhost:7080/springweb/gogo01.do?id=himan
//ex2) http://localhost:7080/springweb/byebye02.do?cnt=25
//ex3) http://localhost:7080/springweb/ohweekend03.do?feel=sogood