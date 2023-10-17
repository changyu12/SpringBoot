<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
 <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
  




</head>
<body>

	<%@include file="menu.jsp" %>

   <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
        <div class="row flex-center">
         <div class="row flex-center py-5">
          <div class="col-sm-10 col-md-8 col-lg-5 col-xl-5 col-xxl-3"><a class="d-flex flex-center text-decoration-none mb-4" href="../../../index.html">
         
              <div class="d-flex align-items-center fw-bolder fs-5 d-inline-block">
              </div>
            </a>
            <div class="text-center mb-7">
              <h3 class="text-1000">로그인</h3>
            </div>
            
            <a href="javascript:kakaologin()" class="btn btn-phoenix-secondary w-100 mb-3"><span class="fab fa-google text-danger me-2 fs--1"></span>카카오 로그인</a>
          <!-- 네이버 로그인 버튼 노출 영역 -->
   			<div id="naver_id_login" class="btn btn-phoenix-secondary w-100"></div>
            <div class="position-relative">
              <hr class="bg-200 mt-5 mb-4" />
              <div class="divider-content-center">이메일 주소로 로그인</div>
            </div>
            <form action="/login" method="post">
            <div class="mb-3 text-start">
              <label class="form-label" for="email">이메일</label>
              <div class="form-icon-container">
                <input class="form-control form-icon-input" name="username" type="email" placeholder="name@example.com" /><span class="fas fa-user text-900 fs--1 form-icon"></span>
              </div>
            </div>
            <div class="mb-3 text-start">
              <label class="form-label" for="password">암호</label>
              <div class="form-icon-container">
                <input class="form-control form-icon-input" name="password" type="password" placeholder="Password" /><span class="fas fa-key text-900 fs--1 form-icon"></span>
              </div>
            </div>
      
              <div class="col-auto"><a class="fs--1 fw-semi-bold" href="#">암호 찾기</a></div>
            
            <button class="btn btn-primary w-100 mb-3">로그인</button>
            </form>
            <div class="text-center"><a class="fs--1 fw-bold" href="/customer/create">회원 가입</a></div>
          </div>
          </div>
        </div>
</main>




<script>
//발급 받은 키
Kakao.init("9eda72310d10e70186b843a0809cac6c");

function kakaologin() {
	window.Kakao.Auth.login({
		// 개발자 사이트에서 체크한 항목들과 반드시 일치해야 한다. 
		scope:'profile_nickname, account_email, gender',
		success: function (authObj) 
			{window.Kakao.API.request({url:'/v2/user/me',
			success:res => {
				
				const nickname = res.kakao_account.profile.nickname;
				const email = res.kakao_account.email;
				const gender = res.kakao_account.gender;
				
				console.log(nickname);
				console.log(email);
				console.log(gender);
				
				kakaoprocess(nickname, email, gender);
				
			}
		});
	}
});
}

function kakaoprocess(nickname, email, gender) {

	$.ajax({
		type:"POST",
		url:"/kakaocheck",
		data:{nickname:nickname,
			  uemail:email,
			  gender:gender
		},
		beforeSend : function(xhr){
			/* 스프링 시큐리티 설정으로 인해 전송 전에 헤더에 csrf값을 넣어야만한다.  */
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			alert("카카오 로그인 성공, 메인 화면으로 이동합니다.");
			window.location.assign('/');
		},
		error : function(request, status, error){
			alert("카카오 로그인 실패, 최초 한번 사이트 회원 가입을 하셔야 합니다.");
			window.location.assign('/customer/create');
		}
	})
}

</script>
  <!-- //네이버 로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("8S_pPtCdskNgUql1ARqx", "http://localhost:8080/naverlogin");
  	var state = naver_id_login.getUniqState();
  	 naver_id_login.setButton("green", 3,40); 
  	naver_id_login.setDomain("http://localhost:8080");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  </script>
</body>
</html>