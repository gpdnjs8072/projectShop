--회원 테이블--
create table tbl_member (
    userId      varchar2(50)    not null, -- 아이디
    userPass    varchar2(100)   not null, -- 비밀번호
    PassQuiz	varchar2(100)	not null, -- 비밀번호 질문
    QuizAnswer	varchar2(100)	not null, -- 질문 답변
    userName    varchar2(30)    not null, -- 이름
    userPhone   varchar2(20)    not null, -- 핸드폰
    email		varchar2(100) 	null, -- 이메일
    userAddr1   varchar2(50)    null, -- 주소1
    userAddr2   varchar2(50)    null, -- 주소2
    userAddr3   varchar2(50)    null, -- 주소3
    regiDate    date            default sysdate, -- 가입날짜
    birthday	date 			not null, -- 생일
    mileage		number			default 0, -- 마일리지
    verify      number          default 0, -- 유저타입
    primary key(userId)
);

-- 회원가입 --
insert into tbl_member (
userId, userPass, PassQuiz, QuizAnswer, userName, userPhone, email, userAddr1, userAddr2, userAddr3, birthday)
values('tkdwh104','kim1002','집에 가고 싶습니까?','네','김대경','010-9950-1095','gosla1002@naver.com','흥도동','흥도로','원흥동',TO_DATE('1993-10-20','yyyy-mm-dd'));

-상품 테이블-




create table tbl_items (
    itemNum       number          not null,
    itemName      varchar2(50)    not null,
    cateCode     varchar2(30)    not null,
    itemPrice     number          not null,
    itemCount     number          default 0,
    itemDes       varchar(500)    null,
    itemImg       varchar(200)    null,
    itemDate      date            default sysdate,
    primary key(itemNum)  
);

-카테고리 테이블-
create table goods_category (
	cateLevel	 varchar2(20)	 not null,
    cateName     varchar2(20)    not null,
    cateCode     varchar2(30)    not null,
    cateCodeRef  varchar2(30)    null,
    primary key(cateCode),
    foreign key(cateCodeRef) references goods_category(cateCode)
);

-별도의 테이블 쿼리-
alter table tbl_items add
    constraint goods_category
    foreign key (cateCode)
        references goods_category(cateCode);

<참고>
alter table [ 테이블 이름 ] add
    constraint [ 제약조건 이름 ]
    foreign key ([ 참조할 컬럼 이름 ])
        references [ 참조되는 테이블 이름 ]([ 참조되는 컬럼 이름 ]);

create sequence tbl_member_seq;

<마스터 유저 만들기 (일반유저:0 , 마스터유저:1)> 
update tbl_member set verify=1 where userId='master';

<level 를 이용한 계층 표시>
select cateLevel, cateName, cateCode, cateCodeRef from goods_category
start with cateCodeRef is null connect by prior cateCode = cateCodeRef;

<level1 카테고리 예시>
insert into goods_category values('1', '악세서리', '100', '');
insert into goods_category values('1', '여성의류', '200', '');
insert into goods_category values('1', '남성의류', '300', '');

<level2 카테고리 예시>
insert into goods_category values('2', '반지', '101', '100');
insert into goods_category values('2', '귀걸이', '102', '100');
insert into goods_category values('2', '목걸이', '103', '100');

create sequence tbl_item_seq;

<아이템 목록 리스트>
 select itemNum, itemName, cateCode, itemPrice, itemCount, itemDes, itemImg, itemDate
 from tbl_items
 order by itemNum desc

 <썸네일 칼럼 추가>
 alter table tbl_items add(itemThumbImg varchar2(300));
 
 <!-- 카테고리별 상품 리스트 : 1차 분류 -->
select i.itemNum, i.itemName, i.cateCode, c.cateCodeRef, c.cateName,
    itemPrice, itemCount, itemDes, itemDate, i.itemImg, i.itemThumbImg
        from tbl_items i
            inner join goods_category c
                on i.cateCode = c.cateCode           
            where i.cateCode = #{cateCode}
             or c.cateCodeRef = #{cateCodeRef}


<!-- 카테고리별 상품 리스트 : 2차 분류 -->
select
    i.itemNum, i.itemName, i.cateCode, c.cateCodeRef, c.cateName,
    itemPrice, itemCount, itemDes, itemDate, i.itemImg, i.itemThumbImg
        from tbl_items i
            inner join goods_category c
                on i.cateCode = c.cateCode           
            where i.cateCode = #{cateCode}
 
<공지 게시판>
CREATE TABLE board_notice(
	num Number PRIMARY key,
	writer VARCHAR2(100) not null, -- 글 작성자의 id
	title VARCHAR2(100) not null,
	content CLOB,
	viewCount NUMBER, -- 조회수
	regdate DATE
);

alter table board_notice add(noticeNum number not null); 

CREATE SEQUENCE board_notice_seq;



<QnA 게시판>
CREATE TABLE board_qna(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL, -- 글 작성자의 id 
	title VARCHAR2(100) NOT NULL,
	content CLOB,
	viewCount NUMBER, -- 조회수
	regdate DATE
);
alter table board_qna add(itemNum number);

CREATE SEQUENCE board_qna_seq;

<QnA 게시판 댓글>
CREATE TABLE board_qna_comment(
	num NUMBER PRIMARY KEY, -- 댓글의 글번호
	writer VARCHAR2(100), -- 댓글 작성자
	content VARCHAR2(500), -- 댓글 내용
	target_id VARCHAR2(100), -- 댓글의대상이되는아이디(글작성자)
	ref_group NUMBER, -- 댓글 그룹번호
	comment_group NUMBER, -- 원글에 달린 댓글 내에서의 그룹번호
	deleted CHAR(3) DEFAULT 'no', -- 댓글이 삭제 되었는지 여부 
	regdate DATE -- 댓글 등록일 
);

CREATE SEQUENCE board_qna_comment_seq;


--리뷰 테이블
create table board_review(
reviewNum number primary key,
reviewWriter varchar2(50) not null,
itemNum number not null,
reviewContent CLOB not null,
likeCount number,
upCount number,
regdate date);

--리뷰 likeCount 제약조건 (1부터 10까지만 입력가능하게)  **추가하기**
alter table board_review 
add constraint review_likeCount_ch check(likeCount>=1 and likeCount<=10);

--리뷰 테이블의 시퀀스
create sequence board_review_seq;

--review comment table
CREATE TABLE board_review_comment(
	num NUMBER PRIMARY KEY, 
	writer VARCHAR2(100), 
	content VARCHAR2(500), 
	target_id VARCHAR2(100), 
	ref_group NUMBER, 
	comment_group NUMBER, 
	deleted CHAR(3) DEFAULT 'no', 
	regdate DATE 
);

--review comment sequence
CREATE SEQUENCE board_review_comment_seq;

--orders table
create table orders(
	orderNum number primary key,
	userId varchar2(50) not null,
	orderRec varchar2(50) not null,   --수신자
	userAddr1 varchar2(20) not null,
	userAddr2 varchar2(50) not null,
	userAddr3 varchar2(50) not null,
	orderPhone1 varchar2(20),
	orderPhone2 varchar2(20),
	orderDate date default sysdate,
	delivery varchar2(30) default '배송준비',    --배송 처리여부
	msg varchar2(100),
	payment varchar2(30),
	allPrice number
);




create sequence orders_seq;

alter table orders
    add constraint orders_userId_fk foreign key(userId)
    references tbl_member(userId);

--orders detail table
create table order_detail(
	odNum number primary key,
	orderNum number,
	itemNum number,
	quantity number,
	result varchar2(30) default '미처리'       --상품 처리여부
);


create sequence order_detail_seq;

alter table order_detail 
	add constraint order_detail_orderNum_fk foreign key(orderNum)
	references orders(orderNum);

alter table order_detail
	add constraint order_detail_itemNum_fk foreign key(itemNum)
	references tbl_items(itemNum);


--카트
create table cartList(
	cartNum number not null,
	userId varchar2(50) not null,
	itemNum number not null,
	cartStock number not null, -- 카트 수량 -- 
	addDate date default sysdate,
	num number,
	itemName varchar2(50),
	itemPrice number,
	itemImg varchar(200) null,
	primary key(cartNum, userId)
);

create sequence cartList_seq;

alter table cartList
add constraint cartList_userId foreign key(userId)
references tbl_member(userId);

alter table cartList
add constraint cartList_itemNum foreign key(itemNum)
references tbl_items(itemNum);


alter table cartList add(money number);


