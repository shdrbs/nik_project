<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<%-- <div>
게시글 : ${qnaList}
</div> --%>

<div class="wrapper">
	<div class="wrpa">
		<div class="content" style="width: 60%; margin: auto; margin-top: 10%;">

			<article>

				<h3 class="my-4">1:1 고객 게시판</h3>

				<h6 class="my-4">고객님의 질문에 대해서 운영자가 1:1 답변을 드립니다.</h6>

				<form name="formm" method="post">

					<table id="qnaList" class="table">
						<tr>
							<th>게시글번호</th>
							<th>제목</th>
							<th>등록일</th>
							<th>답변 여부</th>
						</tr>

						<c:if test="${not empty qnaList}">
							<c:forEach items="${qnaList}" var="qnaVO" varStatus="st">
								<tr>
									<td>${qnaVO.qseq}</td>
									<td><a
										href="${contextPath}/qna/qnaView?qseq=${qnaVO.qseq}">
											${qnaVO.subject} </a></td>
									<td><fmt:formatDate value="${qnaVO.indate}" type="date" />
									</td>
									<td><c:choose>
											<c:when test="${qnaVO.rep==1}"> no </c:when>
											<c:when test="${qnaVO.rep==2}"> yes </c:when>
										</c:choose></td>
								</tr>

							</c:forEach>
						</c:if>

						<c:if test="${empty qnaList}">
							<tr>
								<td colspan="5" class="py-4">
									<div align="center">게시글이 없습니다</div>
								</td>
							</tr>
						</c:if>

					</table>

					<div id="buttons" class="d-flex justify-content-end">

						<div class="pr-1 me-4">

							<input type="button" class="btn btn-secondary" value="1:1 질문하기"
								onclick="location.href='${contextPath}/qna/qnaWriteForm'">
						</div>

						<div class="me-5">
							<input type="button" class="btn btn-secondary" value="쇼핑 계속하기"
								onclick="location.href='${contextPath}/'">
						</div>

					</div>

				</form>

			</article>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>
