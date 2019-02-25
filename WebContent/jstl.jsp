<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.stone.tag.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h4>c:out: 可以对特殊字符进行转换</h4>
	<% 
		request.setAttribute("book", "<<Java>>"); 
	%>
	book: ${requestScope.book }
	<br>
	book: <c:out value="${requestScope.book }"></c:out>
	
	<br><br>
	
	<h4>c:set: 可以为域赋属性值，其中value属性支持EL表达式，还可以为域对象中JavaBean的属性赋值，target，value都支持EL表达式</h4>
	<c:set var="name" value="STONE" scope="page"></c:set>
	name: ${pageScope.name }
	<br>
	<%--
		pageContext.setAttribute("name", "STONE");
	--%>
	<c:set var="subject" value="${param.subject }" scope="session"></c:set>
	subject: ${sessionScope.subject }
	<br>
	<%
		Customer customer = new Customer();
		customer.setId(1001);
		request.setAttribute("customer", customer);
	%>
	ID: ${requestScope.customer.id }
	<br>
	<c:set target="${requestScope.customer }" property="id" value="${param.id }"></c:set>
	ID: ${requestScope.customer.id }
	
	<br><br>
	
	<h4>c:remove: 移除指定域对象的指定属性</h4>
	<c:set var="date" value="1997-07-01" scope="session"></c:set>
	date: ${sessionScope.date }
	<br>
	<c:remove var="date" scope="session"/>
	date: ${sessionScope.date }
	
	<br><br>
	
	<h4>c:if: 没有else，可以把判断的结果存储起来，以备之后使用</h4>
	<c:set var="age" value="20" scope="request"></c:set>
	<c:if test="${requestScope.age > 18 }">成年</c:if>
	<br>
	<c:if test="${param.age > 18 }" var="isAudlt" scope="request"></c:if>
	isAudlt: <c:out value="${requestScope.isAudlt }"></c:out>
	
	<br><br>
	
	<h4>c:choose, c:when, c:otherwise: 可以使用if...else if...else if...else的效果，但较为麻烦</h4>
	<c:choose>
		<c:when test="${param.age > 60 }">老年</c:when>
		<c:when test="${param.age > 40 }">中年</c:when>
		<c:when test="${param.age > 18 }">青年</c:when>
		<c:otherwise>未成年</c:otherwise>
	</c:choose>
	
	<br><br>
	
	<h4>c:forEach: 可以对数组，Collection，Map进行遍历，begin从0开始遍历</h4>
	<c:forEach begin="1" end="10" step="3" var="i">
		${i };
	</c:forEach>
	<br>
	<%
		List<Customer> customers = new ArrayList<Customer>();
		customers.add(new Customer(1,"aaa"));
		customers.add(new Customer(2,"bbb"));
		customers.add(new Customer(3,"ccc"));
		customers.add(new Customer(4,"ddd"));
		customers.add(new Customer(5,"eee"));
		request.setAttribute("customers", customers);
	%>
	<!-- 遍历Collection，遍历数组同Collection -->
	<c:forEach items="${requestScope.customers }" var="customer" begin="0" end="4" step="2" varStatus="status">
		${status.index }:${status.count }:${status.first }:${status.last }:${customer.id } -- ${customer.name } <br>
	</c:forEach>
	
	<!-- 遍历Map -->
	<%
		Map<String, Customer> customersMap = new HashMap<String, Customer>();
		customersMap.put("a", new Customer(1,"aaa"));
		customersMap.put("b", new Customer(2,"bbb"));
		customersMap.put("c", new Customer(3,"ccc"));
		customersMap.put("d", new Customer(4,"ddd"));
		customersMap.put("e", new Customer(5,"eee"));
		request.setAttribute("customersMap", customersMap);
	%>
	<c:forEach items="${requestScope.customersMap }" var="cust">
		${cust.key } - ${cust.value.id } - ${cust.value.name }<br>
	</c:forEach>
	
	<%
		String[] names = new String[]{"a","b","c"};
		request.setAttribute("names", names);
	%>
	<c:forEach items="${names }" var="name">${name }--</c:forEach>
	<br>
	<c:forEach items="${pageContext.session.attributeNames }" var="attrName">
		${attrName }--
	</c:forEach>
	
	<br><br>
	
	<h4>c:forTaken: 处理字符串的，类似于String的split()方法</h4>	
	<c:set var="test" value="a,b,c.d.e.f;g;h;j" scope="request"></c:set>
	<c:forTokens items="${requestScope.test }" delims="," var="s">
		${s }<br>
	</c:forTokens>
	
	<br><br>
	
	<h4>c:import: 可以包含任何页面到当前页面</h4>
	<%-- <c:import url="http://www.baidu.com"></c:import> --%>
	
	<br><br>
	
	<h4>
		c:redirect: 使当前JSP页面重定向到指定的页面.
		使当前JSP转发到指定页面可以使用
		<%-- <jsp:forward page="/el.jsp"></jsp:forward> --%>
	</h4>
	<%-- <c:redirect url="/el.jsp"></c:redirect> --%>
	
	<br><br>
	
	<h4>
		c:url: 产生一个url地址，可以根据Cookie是否可用来智能进行URL重写，对GET请求的参数进行编码
		可以把产生的URL存储在域对象的属性中
		还可以使用c:param为URL添加参数。c:url会对参数进行自动的转码
	</h4>
	<c:url value="/el.jsp" var="elurl" scope="page">
		<c:param name="name" value="STONE"></c:param>
	</c:url>
	url: ${elurl }

</body>
</html>