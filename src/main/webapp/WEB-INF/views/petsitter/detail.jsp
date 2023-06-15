<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세페이지</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="/js/semantic/semantic.min.js"></script>
<link rel="stylesheet" href="/css/detail.css" />
</head>
<body>
	<my:navBar></my:navBar>
	<my:alert></my:alert>
	<h1>로고 자리</h1>
	<!-- 호스트의 집사진 -->
	<div id="imgBox" class="container">
		<button type="button" class="ui icon button inverted " id="entireBtn" data-bs-toggle="modal" data-bs-target="#housePhotosModal">
			<i class="fa-solid fa-plus"></i>
		</button>
		<div class="ui billboard">
			<!-- 대표 사진 -->
			<div id="coverImgBox" class="ui images left floated">
				<label for="entireBtn">
					<img id="coverImg" class="rounded" src="${bucketUrl }/cover/${detail.id }/${detail.cover }">
				</label>
			</div>
			<!-- 상세 사진 -->
			<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" begin="1" end="2">
				<div class="ui image right floated housePhotosBox">
					<label for="entireBtn">
						<img class="rounded housePhotos" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
					</label>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 호스트 간략 정보 -->
	<div class="container" style="width: 900px">
		<h3 class="ui dividing header">Detail</h3>
		<div class="ui items">
			<div class="item">
				<div class="image">
					<c:choose>
						<c:when test="${host.profile eq null or host.profile eq '' }">
							<!-- 프로필 사진 없음 -->
							<img style="width: 150px; height: 150px;" alt="기본 사진" src="/images/paw.png">
						</c:when>
						<c:otherwise>
							<!-- 프로필 사진 있음  -->
							<img style="width: 150px; height: 150px;" src="${bucketUrl }/hostProfile/${host.id }/${host.profile }">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="content">
					<sec:authentication property="name" var="userId" />
					<c:choose>
						<c:when test="${userId eq host.memberId }">
							<a data-bs-toggle="modal" data-bs-target="#deleteModal" class="ui right floated inverted red button">삭제</a>
							<a data-bs-toggle="modal" data-bs-target="#checkModal" class="ui right floated inverted green button">수정</a>
						</c:when>
						<c:when test="${userId ne host.memberId }">
							<sec:authorize access="isAuthenticated()">
								<button class="ui right floated inverted green button" data-bs-toggle="modal" data-bs-target="#exampleModal">예약</button>
							</sec:authorize>
						</c:when>
					</c:choose>
					<a class="header">${host.hostName }</a>
					<div class="meta">
						<span>주소 : ${host.si }시 ${host.gu }구 ${host.dong }동</span>
						<br>
						<span>번호 : ${host.phone }</span>
					</div>
					<div class="description">
						<p>한 줄 소개 : ${detail.title }</p>
					</div>
					<div class="extra">#매일 산책 가능 #샤워 가능 #간식 있음</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 본문 -->
	<div class="container" style="width: 900px; margin-top: 25px;">
		<div class="ui text container">
			<p>${detail.body }</p>
		</div>


		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">반려동물을 선택해주세요</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<c:forEach items="${pet }" var="pet">
       						${pet.id }
      					 </c:forEach>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" onclick="location.href='/book/regiForm/${detail.id}'">예약하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 후기 -->
	<div class="container" style="width: 900px; margin: 25px auto 50px;">
		<div class="ui minimal comments">
			<h3 class="ui dividing header">Comments</h3>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Matt</a>
					<div class="metadata">
						<span class="date">Today at 5:42PM</span>
					</div>
					<div class="text">How artistic!</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
			</div>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Elliot Fu</a>
					<div class="metadata">
						<span class="date">Yesterday at 12:30AM</span>
					</div>
					<div class="text">
						<p>This has been very useful for my research. Thanks as well!</p>
					</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
				<div class="comments">
					<div class="comment">
						<a class="avatar">
							<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
						</a>
						<div class="content">
							<a class="author">Jenny Hess</a>
							<div class="metadata">
								<span class="date">Just now</span>
							</div>
							<div class="text">Elliot you are always so right :)</div>
							<div class="actions">
								<a class="reply">Reply</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Joe Henderson</a>
					<div class="metadata">
						<span class="date">5 days ago</span>
					</div>
					<div class="text">Dude, this is awesome. Thanks so much</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
			</div>
			<form class="ui reply form">
				<div class="field">
					<textarea></textarea>
				</div>
				<div class="ui blue labeled submit icon button">
					<i class="icon edit"></i>
					Add Reply
				</div>
			</form>
		</div>
	</div>

	<!-- 집사진 모달  -->
	<div class="modal fade" id="housePhotosModal" tabindex="-1" aria-labelledby="housePhotosModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="housePhotosModalLabel">전체 보기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- 사진들 -->
					<div id="carouselExampleIndicators" class="carousel slide">
						<div class="carousel-indicators">
							<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" varStatus="status">
								<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status }" class="active" aria-current="true" aria-label="Slide ${status }"></button>
							</c:forEach>
						</div>
						<div class="carousel-inner modalPhoto">
							<div class="carousel-item active">
								<img src="${bucketUrl }/cover/${detail.id }/${detail.cover }" class="d-block w-100 housePhotos">
							</div>
							<c:forEach items="${hostHousePhoto }" var="hostHousePhoto">
								<div class="carousel-item">
									<img class="rounded housePhotos" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
								</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 상세페이지 수정 모달 -->
	<div class="modal fade" id="checkModal" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="checkModalLabel">상세페이지</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">상세페이지를 수정하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<a href="/petsitter/modifyDetail" class="btn btn-primary">수정하기</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 삭제하기 모달 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="deleteModalLabel">삭제 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						호스트 등록 정보를 정말 삭제하시겠습니까?
						<br>
						삭제를 확인하려면 비밀번호를 입력해주세요.
					</div>
					<!-- 삭제하기 정보 -->
					<form action="/petsitter/deleteDetail" method="post" id="deleteForm">
						<input type="hidden" name="hostId" value="${host.id }">
						<input class="form-control" type="text" name="password" id="passwordInput" placeholder="비밀번호를 입력해주세요.">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<button type="submit" class="btn btn-danger" form="deleteForm">삭제하기</button>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript">
		function openModal() {
			document.getElementById("myModal").style.display = "block";
		}
	</script>
</body>
</html>