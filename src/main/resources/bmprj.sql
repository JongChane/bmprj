SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS gamer;
DROP TABLE IF EXISTS gamelist;
DROP TABLE IF EXISTS visit;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS lane;
DROP TABLE IF EXISTS user;




/* Create Tables */

-- 게시판
CREATE TABLE board
(
	board_num int NOT NULL COMMENT '게시물번호',
	user_id varchar(20) NOT NULL COMMENT '아이디',
	board_title varchar(100) COMMENT '제목',
	board_content varchar(3000) COMMENT '내용',
	board_readcnt int COMMENT '조회수',
	board_url varchar(100) COMMENT '사진정보',
	board_id int COMMENT '게시판번호',
	board_date date COMMENT '날짜',
	PRIMARY KEY (board_num)
) COMMENT = '게시판';

-- 공지사항
CREATE TABLE notice
(
	notice_num int NOT NULL COMMENT '게시물번호',
	admin_id varchar(20) NOT NULL COMMENT '아이디',
	notice_title varchar(100) COMMENT '제목',
	notice_content varchar(3000) COMMENT '내용',
	notice_regdate date COMMENT '날짜',
	notice_readcnt int COMMENT '조회수',
	PRIMARY KEY (notice_num)
) COMMENT = '공지사항';


-- 댓글
CREATE TABLE comment
(
	comm_num int NOT NULL COMMENT '번호',
	board_num int NOT NULL COMMENT '게시물번호',
	user_id varchar(20) NOT NULL COMMENT '아이디',
	comm_content varchar(3000) COMMENT '내용',
	comm_grp int COMMENT '댓글번호',
	comm_grpstep int COMMENT '대댓글번호',
	comm_grplevel int COMMENT '대댓글의대댓글',
	PRIMARY KEY (comm_num)
) COMMENT = '댓글';


-- 소셜매치
CREATE TABLE gamelist
(
	game_num int NOT NULL AUTO_INCREMENT COMMENT '매치번호',
	user_id varchar(20) NOT NULL COMMENT '아이디',
	game_title varchar(30) COMMENT '제목',
	game_content varchar(1000) COMMENT '내용',
	game_max int COMMENT '최대인원',
	game_people int COMMENT '신청인원',
	game_date date COMMENT '게임날짜',
	game_age int COMMENT '제한나이',
	game_gender varchar(30) COMMENT '제한성별',
	game_avg int COMMENT '제한에버',
	PRIMARY KEY (game_num)
) COMMENT = '소셜매치';


-- 게이머 정보
CREATE TABLE gamer
(
	user_id varchar(20) NOT NULL COMMENT '아이디',
	game_num int NOT NULL COMMENT '매치번호',
	PRIMARY KEY (user_id, game_num)
) COMMENT = '게이머 정보';


-- 레인정보
CREATE TABLE lane
(
	lane_num int NOT NULL COMMENT '레인번호',
	lane_type varchar(100) NOT NULL COMMENT '오일패턴',
	PRIMARY KEY (lane_num)
) COMMENT = '레인정보';


-- 예약정보
CREATE TABLE reservation
(
	rv_num int NOT NULL AUTO_INCREMENT COMMENT '예약번호',
	user_id varchar(20) NOT NULL COMMENT '아이디',
	lane_num int NOT NULL COMMENT '레인번호',
	rv_now date COMMENT '예약한 날짜',
	rv_date date COMMENT '예약할 날짜',
	rv_game int COMMENT '게임수',
	rv_start time COMMENT '게임시작시간',
	rv_end time COMMENT '게임종료시간',
	rv_people int COMMENT '인원',
	rv_check varchar(30) COMMENT '예약상태',
	PRIMARY KEY (rv_num)
) COMMENT = '예약정보';


-- 회원정보
CREATE TABLE user
(
	user_id varchar(20) NOT NULL COMMENT '아이디',
	user_pass varchar(200) COMMENT '비밀번호',
	user_name varchar(20) COMMENT '이름',
	user_age int COMMENT '나이',
	user_gender varchar(20) COMMENT '성별',
	user_tel varchar(30) COMMENT '전화번호',
	user_email varchar(50) COMMENT '이메일',
	user_avg int COMMENT '에버점수',
	PRIMARY KEY (user_id)
) COMMENT = '회원정보';


-- 게임결과
CREATE TABLE visit
(
	vi_id varchar(30) NOT NULL COMMENT '방문자아이디',
	rv_num int NOT NULL COMMENT '예약번호',
	vi_total int COMMENT '총점',
	vi_avg int COMMENT '에버점수',
	vi_game int COMMENT '실제게임수',
	PRIMARY KEY (vi_id)
) COMMENT = '게임결과';



/* Create Foreign Keys */

ALTER TABLE comment
	ADD FOREIGN KEY (board_num)
	REFERENCES board (board_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE gamer
	ADD FOREIGN KEY (game_num)
	REFERENCES gamelist (game_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reservation
	ADD FOREIGN KEY (lane_num)
	REFERENCES lane (lane_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE visit
	ADD FOREIGN KEY (rv_num)
	REFERENCES reservation (rv_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE board
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE notice
	ADD FOREIGN KEY (admin_id)
	REFERENCES user (admin_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE comment
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE gamelist
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE gamer
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reservation
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



